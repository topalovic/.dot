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

# Display project/folder name in prompt
Pry.config.prompt_name = File.basename(Dir.pwd)

# Display env in prompt if applicable
if env = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || ENV["ENVIRONMENT"]
  env = Pry::Helpers::Text.red(env)
  prompt = Pry.config.prompt
  Pry.config.prompt = [
    proc { |*a| "[#{env}] #{prompt[0].call(*a)}" },
    proc { |*a| "[#{env}] #{prompt[1].call(*a)}" }
  ]
end

# Aliases for standard commands
Pry::Commands.alias_command "reload", "reload-method"

# My command set
my_command_set = Pry::CommandSet.new do

  # TODO Try to shoehorn seed structures here

  block_command "fortune" do |name|
    msg = `fortune` rescue "You might want to install fortune first."
    output.puts msg
  end

  # Aux methods for use by all commands within the set
  helpers do
  end
end

Pry::Commands.import my_command_set

# Debugger
if defined?(PryByebug)

  # Remove annoying PryByebug shortcuts
  begin
    Pry::Commands.delete "c"
    Pry::Commands.delete "s"
    Pry::Commands.delete "n"
    Pry::Commands.delete "f"
  rescue
  end

  # That's more like it
  Pry::Commands.alias_command "cc", "continue"
  Pry::Commands.alias_command "ss", "step"
  Pry::Commands.alias_command "nn", "next"
  Pry::Commands.alias_command "ff", "finish"
end
