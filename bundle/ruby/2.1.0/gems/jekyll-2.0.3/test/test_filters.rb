require 'helper'

class TestFilters < Test::Unit::TestCase
  class JekyllFilter
    include Jekyll::Filters
    attr_accessor :site, :context

    def initialize(opts = {})
      @site = Jekyll::Site.new(Jekyll.configuration(opts))
      @context = Liquid::Context.new({}, {}, { :site => @site })
    end
  end

  context "filters" do
    setup do
      @filter = JekyllFilter.new({"source" => source_dir, "destination" => dest_dir})
      @sample_time = Time.utc(2013, 03, 27, 11, 22, 33)
      @time_as_string = "September 11, 2001 12:46:30 -0000"
      @array_of_objects = [
        { "color" => "red",  "size" => "large"  },
        { "color" => "red",  "size" => "medium" },
        { "color" => "blue", "size" => "medium" }
      ]
    end

    should "textilize with simple string" do
      assert_equal "<p>something <strong>really</strong> simple</p>", @filter.textilize("something *really* simple")
    end

    should "markdownify with simple string" do
      assert_equal "<p>something <strong>really</strong> simple</p>\n", @filter.markdownify("something **really** simple")
    end

    should "convert array to sentence string with no args" do
      assert_equal "", @filter.array_to_sentence_string([])
    end

    should "convert array to sentence string with one arg" do
      assert_equal "1", @filter.array_to_sentence_string([1])
      assert_equal "chunky", @filter.array_to_sentence_string(["chunky"])
    end

    should "convert array to sentence string with two args" do
      assert_equal "1 and 2", @filter.array_to_sentence_string([1, 2])
      assert_equal "chunky and bacon", @filter.array_to_sentence_string(["chunky", "bacon"])
    end

    should "convert array to sentence string with multiple args" do
      assert_equal "1, 2, 3, and 4", @filter.array_to_sentence_string([1, 2, 3, 4])
      assert_equal "chunky, bacon, bits, and pieces", @filter.array_to_sentence_string(["chunky", "bacon", "bits", "pieces"])
    end

    context "date filters" do
      context "with Time object" do
        should "format a date with short format" do
          assert_equal "27 Mar 2013", @filter.date_to_string(@sample_time)
        end

        should "format a date with long format" do
          assert_equal "27 March 2013", @filter.date_to_long_string(@sample_time)
        end

        should "format a time with xmlschema" do
          assert_equal "2013-03-27T11:22:33Z", @filter.date_to_xmlschema(@sample_time)
        end

        should "format a time according to RFC-822" do
          assert_equal "Wed, 27 Mar 2013 11:22:33 -0000", @filter.date_to_rfc822(@sample_time)
        end
      end

      context "with String object" do
        should "format a date with short format" do
          assert_equal "11 Sep 2001", @filter.date_to_string(@time_as_string)
        end

        should "format a date with long format" do
          assert_equal "11 September 2001", @filter.date_to_long_string(@time_as_string)
        end

        should "format a time with xmlschema" do
          assert_equal "2001-09-11T12:46:30Z", @filter.date_to_xmlschema(@time_as_string)
        end

        should "format a time according to RFC-822" do
          assert_equal "Tue, 11 Sep 2001 12:46:30 -0000", @filter.date_to_rfc822(@time_as_string)
        end
      end
    end

    should "escape xml with ampersands" do
      assert_equal "AT&amp;T", @filter.xml_escape("AT&T")
      assert_equal "&lt;code&gt;command &amp;lt;filename&amp;gt;&lt;/code&gt;", @filter.xml_escape("<code>command &lt;filename&gt;</code>")
    end

    should "not error when xml escaping nil" do
      assert_equal "", @filter.xml_escape(nil)
    end

    should "escape space as plus" do
      assert_equal "my+things", @filter.cgi_escape("my things")
    end

    should "escape special characters" do
      assert_equal "hey%21", @filter.cgi_escape("hey!")
    end

    should "escape space as %20" do
      assert_equal "my%20things", @filter.uri_escape("my things")
    end

    context "jsonify filter" do
      should "convert hash to json" do
        assert_equal "{\"age\":18}", @filter.jsonify({:age => 18})
      end

      should "convert array to json" do
        assert_equal "[1,2]", @filter.jsonify([1, 2])
        assert_equal "[{\"name\":\"Jack\"},{\"name\":\"Smith\"}]", @filter.jsonify([{:name => 'Jack'}, {:name => 'Smith'}])
      end
    end

    context "group_by filter" do
      should "successfully group array of Jekyll::Page's" do
        @filter.site.process
        grouping = @filter.group_by(@filter.site.pages, "layout")
        grouping.each do |g|
          assert ["default", "nil", ""].include?(g["name"]), "#{g['name']} isn't a valid grouping."
          case g["name"]
          when "default"
            assert g["items"].is_a?(Array), "The list of grouped items for 'default' is not an Array."
            assert_equal 5, g["items"].size
          when "nil"
            assert g["items"].is_a?(Array), "The list of grouped items for 'nil' is not an Array."
            assert_equal 2, g["items"].size
          when ""
            assert g["items"].is_a?(Array), "The list of grouped items for '' is not an Array."
            assert_equal 10, g["items"].size
          end
        end
      end
    end

    context "where filter" do
      should "return any input that is not an array" do
        assert_equal Hash.new, @filter.where(Hash.new, nil, nil)
        assert_equal "some string", @filter.where("some string", "la", "le")
      end

      should "filter objects appropriately" do
        assert_equal 2, @filter.where(@array_of_objects, "color", "red").length
      end
    end

    context "sort filter" do
      should "return sorted numbers" do
        assert_equal [1, 2, 2.2, 3], @filter.sort([3, 2.2, 2, 1])
      end
      should "return sorted strings" do
        assert_equal ["10", "2"], @filter.sort(["10", "2"])
        assert_equal [{"a" => "10"}, {"a" => "2"}], @filter.sort([{"a" => "10"}, {"a" => "2"}], "a")
        assert_equal ["FOO", "Foo", "foo"], @filter.sort(["foo", "Foo", "FOO"])
        assert_equal ["_foo", "foo", "foo_"], @filter.sort(["foo_", "_foo", "foo"])
      end
      should "return sorted by property array" do
        assert_equal [{"a" => 1}, {"a" => 2}, {"a" => 3}, {"a" => 4}],
          @filter.sort([{"a" => 4}, {"a" => 3}, {"a" => 1}, {"a" => 2}], "a")
      end
      should "return sorted by property array with nils first" do
        ary = [{"a" => 2}, {"b" => 1}, {"a" => 1}]
        assert_equal [{"b" => 1}, {"a" => 1}, {"a" => 2}], @filter.sort(ary, "a")
        assert_equal @filter.sort(ary, "a"), @filter.sort(ary, "a", "first")
      end
      should "return sorted by property array with nils last" do
        assert_equal [{"a" => 1}, {"a" => 2}, {"b" => 1}],
          @filter.sort([{"a" => 2}, {"b" => 1}, {"a" => 1}], "a", "last")
      end
    end

  end
end
