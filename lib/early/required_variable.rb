# frozen_string_literal: true

require 'early/missing_error'

module Early
  # RequiredVariable is an ENV variable that needs to be provided by the
  # environment. If it's missing, 
  class RequiredVariable
    attr_reader :name

    def initialize(name)
      @name = String(name)
    end

    def apply
      ENV.fetch(name) { raise MissingError, self }
    end

    def inspect
      "ENV[#{name.inspect}]"
    end
  end
end
