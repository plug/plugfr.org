require 'helper'

class TestFilters < Test::Unit::TestCase
  class JekyllFilter
    include Jekyll::Filters

    def initialize
      site = Jekyll::Site.new(Jekyll.configuration({}))
      @context = Liquid::Context.new({}, {}, { :site => site })
    end
  end

  context "filters" do
    setup do
      @filter = JekyllFilter.new
      @sample_time = Time.utc(2013, 03, 27, 11, 22, 33)
      @time_as_string = "September 11, 2001 12:46:30 -0000"
    end

    should "textilize with simple string" do
      assert_equal "<p>something <strong>really</strong> simple</p>", @filter.textilize("something *really* simple")
    end

    should "markdownify with simple string" do
      assert_equal "<p>something <strong>really</strong> simple</p>", @filter.markdownify("something **really** simple")
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

    should "escape space as plus" do
      assert_equal "my+things", @filter.cgi_escape("my things")
    end

    should "escape special characters" do
      assert_equal "hey%21", @filter.cgi_escape("hey!")
    end

    should "escape space as %20" do
      assert_equal "my%20things", @filter.uri_escape("my things")
    end
  end
end
