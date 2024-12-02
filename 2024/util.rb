# frozen_string_literal: true

class Util
  def self.load_inputs(env)
    location = env == 'test' ? 'example.txt' : 'actual.txt'

    File.read(location)
  end
end
