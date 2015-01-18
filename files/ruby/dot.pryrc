#!/usr/bin/env ruby

# Some common tools
%w[awesome_print pry-nav pry-remote].each do |file|
  begin
    require file
  rescue LoadError
  end
end

# My playground setup
begin
  load File.expand_path("~/.rubyrc")
  include RubyRC
rescue LoadError
end

# Display project/folder name in prompt
Pry.config.prompt_name = File.basename(Dir.pwd)

# Display env in prompt if applicable
if env = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || ENV["ENVIRONMENT"]
  _prompt = Pry.config.prompt
  env = Pry::Helpers::Text.red(env)
  Pry.config.prompt = [
    proc { |*a| "[#{env}] #{_prompt[0].call(*a)}" },
    proc { |*a| "[#{env}] #{_prompt[1].call(*a)}" }
  ]
end
