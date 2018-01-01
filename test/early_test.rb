require 'test_helper'

class EarlyTest < Test
  test 'applies environment variable requirements' do
    assert_raises Early::Error do
      Early do
        require :FOO
      end
    end

    ENV['FOO'] = 'BAR'
    Early do
      require :FOO
      default :BAR, 'FOO'
    end

    assert_equal 'FOO', ENV['BAR']
  end

  test 'applies environment variable requirements only for a group' do
    Early :production do
      require :FOO
    end

    ENV['RAILS_ENV'] = 'production'
    assert_raises Early::Error do
      Early :production do
        require :FOO
      end
    end
  end
end
