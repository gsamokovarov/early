# frozen_string_literal: true

module Early
  # MissingError is raised when an environment variable is missing.
  class MissingError < KeyError
    attr_reader :variable

    def initialize(variable)
      @variable = variable

      super("Variable #{variable.inspect} is missing")
    end
  end
end
