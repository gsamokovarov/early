require 'test_helper'

module Early
  class ConfigurationTest < Test
    test 'convert configuration to variables' do
      config = Configuration.new do
        require :FOO
        default :BAR, 42
      end

      assert_equal 2, config.variables.count
      assert_equal 'FOO', config.variables[0].name
      assert_equal 'BAR', config.variables[1].name
      assert_equal '42', config.variables[1].value
    end
  end
end
