# frozen_string_literal: true

require 'early/configuration'
require 'early/version'

# Early set rules about the environment variables in the current application.
#
# Example:
#
#   Early do
#     require :REDIS_URL
#     default :PROVIDER, :coinbase
#   end
def Early(*groups, &block)
  config = Early::Configuration.new(&block)

  if groups.empty? || groups.find { |g| Early.group == g.to_s }
    Early.apply(config)
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
