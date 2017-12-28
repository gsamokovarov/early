# frozen_string_literal: true

module Early
  # DefaultVariable represents an optional ENV variable that can be omitted
  # by the environment. However, a default value will be always be set.
  class DefaultVariable
    attr_reader :name
    attr_reader :value

    def initialize(name, value)
      @name = String(name)
      @value = String(value)
    end

    def apply
      ENV[name] ||= value
    end

    def inspect
      "ENV[#{name.inspect}] = #{value.inspect}"
    end
  end
end
