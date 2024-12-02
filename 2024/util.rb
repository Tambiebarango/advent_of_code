# frozen_string_literal: true

class Util
  def self.load_inputs(env, day)
    location = env == 'test' ? 'example.txt' : 'actual.txt'

    File.read("files/#{day}/#{location}")
  end
end
