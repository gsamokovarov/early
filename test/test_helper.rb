$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "early"

require "minitest/autorun"

class Test < Minitest::Test
  def self.test(name, &block)
    define_method("test_#{name}", &block)
  end

  def setup
    reset_env
  end

  private

  # Because dup will return a plain Object, without any of the ENV special
  # methods.
  PRISTINE_ENV = ENV.map(&:itself).to_h

  def reset_env
    ENV.delete_if { |env| PRISTINE_ENV[env].nil? }
    PRISTINE_ENV.each { |env, val| ENV[env] = val }
  end
end
