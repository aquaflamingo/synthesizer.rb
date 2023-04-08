# frozen_string_literal: true

require_relative "synthesizer/version"
require_relative "synthesizer/simple"

module Synthesizer
  class Factory
    class << self 
      def make(type = :simple)
        case type 
        when :simple 
          Simple.new
        end
      end
    end
  end
end
