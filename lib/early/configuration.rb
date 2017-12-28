# frozen_string_literal: true

require 'early/required_variable'
require 'early/default_variable'

module Early
  # Configuration is a set of required and optional environment variables that
  # Early can apply.
  class Configuration
    attr_reader :variables

    def initialize(&block)
      @variables = []

      instance_eval(&block)
    end

    private

    def require(name)
      @variables << RequiredVariable.new(name)
    end

    def default(name, value)
      @variables << DefaultVariable.new(name, value)
    end
  end
end
