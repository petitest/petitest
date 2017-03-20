module Petitest
  class AutoRunner
    class << self
      # @return [Petitest::AutoRunner]
      def singleton
        @singleton ||= new
      end
    end

    # @todo
    def run
      puts "#{self.class}##{__method__}"
    end
  end
end
