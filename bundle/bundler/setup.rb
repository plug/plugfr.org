require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/blankslate-2.1.2.4/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/hitimes-1.2.2")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/hitimes-1.2.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/timers-4.0.1/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/celluloid-0.16.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/fast-stemmer-1.0.2")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/fast-stemmer-1.0.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/classifier-reborn-2.0.3/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/coffee-script-source-1.8.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/execjs-2.2.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/coffee-script-2.3.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/colorator-0.1/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/ffi-1.9.6")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/ffi-1.9.6/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-coffeescript-1.0.1/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-gist-1.1.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-paginate-1.1.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/sass-3.4.9/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-sass-converter-1.3.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/rb-fsevent-0.9.4/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/rb-inotify-0.9.5/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/listen-2.8.4/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-watch-1.2.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/kramdown-1.5.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/liquid-2.6.1/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/mercenary-0.3.5/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/posix-spawn-0.3.9")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/posix-spawn-0.3.9/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/yajl-ruby-1.1.0")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/yajl-ruby-1.1.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/pygments.rb-0.6.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/extensions/x86_64-darwin-13/2.1.0-static/redcarpet-3.2.2")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/redcarpet-3.2.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/safe_yaml-1.0.4/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/parslet-1.5.0/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/toml-0.1.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/jekyll-2.5.3/lib")
