# frozen_string_literal: true

require 'test_helper'

class EarlyTest < Test
  test 'applies environment variable requirements' do
    assert_raises Early::Error do
      Early do
        require :FOO
      end
    end

    ENV['FOO'] = 'BAR'
    assert_raises Early::Error do
      Early do
        require :FOO, :BAR
      end
    end

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

  test 'convert configuration to variables' do
    config = Early::Configuration.new do
      require :FOO
      default :BAR, 42
    end

    assert_equal 2, config.variables.count
    assert_equal 'FOO', config.variables[0].name
    assert_equal 'BAR', config.variables[1].name
    assert_equal '42', config.variables[1].value
  end

  test 'applies a default value' do
    assert_nil ENV['FOO']

    var = Early::DefaultVariable.new('FOO', 'BAR')
    var.apply

    assert_equal 'BAR', ENV['FOO']
  end

  test 'requires a default value' do
    var = Early::RequiredVariable.new('FOO')

    err =
      assert_raises Early::Error do
        var.apply
      end

    assert_equal var, err.variable
  end

  test 'can set environment variables from a travis config' do
    config = Early::Configuration.new do
      travis Pathname.new("#{__dir__}/fixtures/.travis.yml")
    end

    assert_equal 'admin', ENV['ADMIN_NAME']
    assert_equal 'admin', ENV['ADMIN_PASSWORD']
    assert_equal 'test', ENV['MEETUP_API_KEY']
  end

  test 'travis does not loat RAILS_ENV' do
    config = Early::Configuration.new do
      travis Pathname.new("#{__dir__}/fixtures/.travis.yml")
    end

    assert ENV['RAILS_ENV'].nil?
  end

  test 'travis does not loat DATABASE_URL' do
    config = Early::Configuration.new do
      travis Pathname.new("#{__dir__}/fixtures/.travis.yml")
    end

    assert ENV['DATABASE_URL'].nil?
  end
end
