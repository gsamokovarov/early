# frozen_string_literal: true

require 'early/configuration'
require 'early/version'

# Early checks for environment variables availability. It provides a DSL that
# can enforce environment variable availability or set a default value. This
# will help you catch configuration errors earlier in your application runtime.
# Here is an example:
#
#   Early do
#     require :REDIS_URL
#     default :PROVIDER, :generic
#   end
#
# Calling <tt>require :REDIS_URL</tt> will fail if <tt>ENV['REDIS_URL']</tt> is
# <tt>nil</tt>, which means that it wasn't provided, before running the current
# application. The error will give you information about the missing variable:
#
#   Early::MissingError (Variable ENV["REDIS_URL"] is missing)
#
# Setting a default calls <tt>ENV['PROVIDER'] ||= 'generic'</tt> under the
# hood.  Every time you use <tt>ENV['PROVIDER']</tt> will give you
# <tt>'generic'</tt>. No need to set it explicitly prior to the application
# run.
#
# A quick note about how <tt>ENV</tt> works in Ruby. It is a plain
# <tt>Object</tt> that is monkey patched to behave a bit like a hash. You can
# get an variable with <tt>ENV['NAME']</tt> and you can set an environment
# variable with <tt>ENV['NAME'] = 'val'</tt>.
#
# Both of the operations explicitly require strings for the variable name and
# value.  Passing a symbol to <tt>ENV[:NAME]</tt> will result in an error. The
# same will happen if you try to set a variable to any non-string value, like
# <tt>ENV['NAME'] = :val</tt>. Early converts both the name and the value to
# strings when it eventually deals with <tt>ENV</tt>, so you don't have to
# worry about it.
module Kernel
  def Early(*groups, &block)
    config = Early::Configuration.new(&block)

    if groups.empty? || groups.find { |g| Early.group == g.to_s }
      Early.apply(config)
    end
  end
end

# Early checks for environment variables availability, so you don't have to.
#
# Hook it early in your program and work with `ENV` like you normally would.
# This time, however, the errors would be thrown early and not when a critical
# piece of code is hit, which may happen late in the program runtime an be easy
# to miss.
module Early
  def self.group
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.apply(config)
    config.variables.each(&:apply)
  end
end
