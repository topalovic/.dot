#!/usr/bin/env ruby

# Some common tools
%w[awesome_print pry-remote].each do |file|
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

if defined?(PryByebug)
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'ff', 'finish'

  # Hit Enter to repeat last command
  Pry::Commands.command /^$/, "repeat last command" do
    _pry_.run_command Pry.history.to_a.last
  end
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
