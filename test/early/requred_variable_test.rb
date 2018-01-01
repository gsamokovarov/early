# frozen_string_literal: true

require 'test_helper'

module Early
  class RequiredVariableTest < Test
    test 'requires a default value' do
      var = RequiredVariable.new('FOO')

      err =
        assert_raises Error do
          var.apply
        end

      assert_equal var, err.variable
    end
  end
end
