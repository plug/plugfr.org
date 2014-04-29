require 'helper'

class TestConfiguration < Test::Unit::TestCase
  context "#stringify_keys" do
    setup do
      @mixed_keys = Configuration[{
        'markdown' => 'maruku',
        :permalink => 'date',
        'baseurl'  => '/',
        :include   => ['.htaccess'],
        :source    => './'
      }]
      @string_keys = Configuration[{
        'markdown'  => 'maruku',
        'permalink' => 'date',
        'baseurl'   => '/',
        'include'   => ['.htaccess'],
        'source'    => './'
      }]
    end
    should "stringify symbol keys" do
      assert_equal @string_keys, @mixed_keys.stringify_keys
    end
    should "not mess with keys already strings" do
      assert_equal @string_keys, @string_keys.stringify_keys
    end
  end
  context "#config_files" do
    setup do
      @config = Configuration[{"source" => source_dir}]
      @no_override     = {}
      @one_config_file = {"config" => "config.yml"}
      @multiple_files  = {"config" => %w[config/site.yml config/deploy.yml configuration.yml]}
    end

    should "always return an array" do
      assert @config.config_files(@no_override).is_a?(Array)
      assert @config.config_files(@one_config_file).is_a?(Array)
      assert @config.config_files(@multiple_files).is_a?(Array)
    end
    should "return the default config path if no config files are specified" do
      assert_equal [File.join(source_dir, "_config.yml")], @config.config_files(@no_override)
    end
    should "return the config if given one config file" do
      assert_equal %w[config.yml], @config.config_files(@one_config_file)
    end
    should "return an array of the config files if given many config files" do
      assert_equal %w[config/site.yml config/deploy.yml configuration.yml], @config.config_files(@multiple_files)
    end
  end
  context "#backwards_compatibilize" do
    setup do
      @config = Configuration[{
        "auto"    => true,
        "watch"   => true,
        "server"  => true,
        "exclude" => "READ-ME.md, Gemfile,CONTRIBUTING.hello.markdown",
        "include" => "STOP_THE_PRESSES.txt,.heloses, .git"
      }]
    end
    should "unset 'auto' and 'watch'" do
      assert @config.has_key?("auto")
      assert @config.has_key?("watch")
      assert !@config.backwards_compatibilize.has_key?("auto")
      assert !@config.backwards_compatibilize.has_key?("watch")
    end
    should "unset 'server'" do
      assert @config.has_key?("server")
      assert !@config.backwards_compatibilize.has_key?("server")
    end
    should "transform string exclude into an array" do
      assert @config.has_key?("exclude")
      assert @config.backwards_compatibilize.has_key?("exclude")
      assert_equal @config.backwards_compatibilize["exclude"], %w[READ-ME.md Gemfile CONTRIBUTING.hello.markdown]
    end
    should "transform string include into an array" do
      assert @config.has_key?("include")
      assert @config.backwards_compatibilize.has_key?("include")
      assert_equal @config.backwards_compatibilize["include"], %w[STOP_THE_PRESSES.txt .heloses .git]
    end
  end
  context "#fix_common_issues" do
    setup do
      @config = Proc.new do |val|
        Configuration[{
          'paginate' => val
        }]
      end
    end
    should "sets an invalid 'paginate' value to nil" do
      assert_nil @config.call(0).fix_common_issues['paginate']
      assert_nil @config.call(-1).fix_common_issues['paginate']
      assert_nil @config.call(true).fix_common_issues['paginate']
    end
  end
  context "loading configuration" do
    setup do
      @path = File.join(Dir.pwd, '_config.yml')
      @user_config = File.join(Dir.pwd, "my_config_file.yml")
    end

    should "fire warning with no _config.yml" do
      mock(YAML).safe_load_file(@path) { raise SystemCallError, "No such file or directory - #{@path}" }
      mock($stderr).puts("Configuration file: none".yellow)
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({})
    end

    should "load configuration as hash" do
      mock(YAML).safe_load_file(@path) { Hash.new }
      mock($stdout).puts("Configuration file: #{@path}")
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({})
    end

    should "fire warning with bad config" do
      mock(YAML).safe_load_file(@path) { Array.new }
      mock($stderr).puts(("WARNING: ".rjust(20) + "Error reading configuration. Using defaults (and options).").yellow)
      mock($stderr).puts("Configuration file: (INVALID) #{@path}".yellow)
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({})
    end

    should "fire warning when user-specified config file isn't there" do
      mock(YAML).safe_load_file(@user_config) { raise SystemCallError, "No such file or directory - #{@user_config}" }
      mock($stderr).puts(("Fatal: ".rjust(20) + "The configuration file '#{@user_config}' could not be found.").red)
      assert_raises LoadError do
        Jekyll.configuration({'config' => [@user_config]})
      end
    end
  end
  context "loading config from external file" do
    setup do
      @paths = {
        :default => File.join(Dir.pwd, '_config.yml'),
        :other   => File.join(Dir.pwd, '_config.live.yml'),
        :empty   => ""
      }
    end

    should "load default config if no config_file is set" do
      mock(YAML).safe_load_file(@paths[:default]) { Hash.new }
      mock($stdout).puts("Configuration file: #{@paths[:default]}")
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({})
    end

    should "load different config if specified" do
      mock(YAML).safe_load_file(@paths[:other]) { {"baseurl" => "http://wahoo.dev"} }
      mock($stdout).puts("Configuration file: #{@paths[:other]}")
      assert_equal Jekyll::Configuration::DEFAULTS.deep_merge({ "baseurl" => "http://wahoo.dev" }), Jekyll.configuration({ "config" => @paths[:other] })
    end

    should "load default config if path passed is empty" do
      mock(YAML).safe_load_file(@paths[:default]) { Hash.new }
      mock($stdout).puts("Configuration file: #{@paths[:default]}")
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({ "config" => @paths[:empty] })
    end

    should "load multiple config files" do
      mock(YAML).safe_load_file(@paths[:default]) { Hash.new }
      mock(YAML).safe_load_file(@paths[:other]) { Hash.new }
      mock($stdout).puts("Configuration file: #{@paths[:default]}")
      mock($stdout).puts("Configuration file: #{@paths[:other]}")
      assert_equal Jekyll::Configuration::DEFAULTS, Jekyll.configuration({ "config" => [@paths[:default], @paths[:other]] })
    end

    should "load multiple config files and last config should win" do
      mock(YAML).safe_load_file(@paths[:default]) { {"baseurl" => "http://example.dev"} }
      mock(YAML).safe_load_file(@paths[:other]) { {"baseurl" => "http://wahoo.dev"} }
      mock($stdout).puts("Configuration file: #{@paths[:default]}")
      mock($stdout).puts("Configuration file: #{@paths[:other]}")
      assert_equal Jekyll::Configuration::DEFAULTS.deep_merge({ "baseurl" => "http://wahoo.dev" }), Jekyll.configuration({ "config" => [@paths[:default], @paths[:other]] })
    end
  end
end
