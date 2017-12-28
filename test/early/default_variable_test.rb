# frozen_string_literal: true

require 'test_helper'

module Early
  class DefaultVariableTest < Test
    test 'applies a default value' do
      assert_nil ENV['FOO']

      var = DefaultVariable.new('FOO', 'BAR')
      var.apply

      assert_equal 'BAR', ENV['FOO']
    end
  end
end
