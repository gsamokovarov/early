require 'pathname'
require 'yaml'

module Early
  class Travis
    def self.from_config(path)
      path = Pathname.new(path.to_s).expand_path
      config = YAML.load_file(path)

      envs = Array(config.dig('env', 'global')).map do |line|
        line.split('=', 2)
      end

      new(envs)
    end

    def initialize(envs)
      @envs = envs
    end

    def apply(except: nil)
      except = Array(except).map(&:to_s)

      @envs.each do |name, value|
        next if except.include?(name)

        ENV[name] ||= value
      end
    end
  end
end
