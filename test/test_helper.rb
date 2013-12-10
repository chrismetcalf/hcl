require 'bundler'

begin
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
    add_filter '/vendor/' # for travis-ci
    add_filter do |source_file|
      source_file.lines.count < 15
    end
    # source: https://travis-ci.org/zenhob/hcl
    minimum_coverage case RUBY_ENGINE
      when "rbx" then 84
      when "jruby" then 73
      else 77
    end
  end
rescue LoadError => e
  $stderr.puts 'No test coverage tools found, skipping coverage check.'
end

require 'minitest/autorun'
require 'mocha/setup'
require 'fileutils'
require 'fakeweb'

# override the default hcl dir
ENV['HCL_DIR'] = File.dirname(__FILE__)+"/dot_hcl"

require 'hcl'


