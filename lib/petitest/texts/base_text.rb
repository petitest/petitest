module Petitest
  module Texts
    class BaseText
      ANSI_COLOR_CODE_BY_COLOR_TYPE = {
        black: 30,
        blue: 34,
        bold: 1,
        cyan: 36,
        green: 32,
        magenta: 35,
        red: 31,
        white: 37,
        yellow: 33,
      }

      # @note Override
      def to_s
        raise ::NotImplementedError
      end

      private

      # @param color_type [Symbol]
      # @return [Integer]
      def ansi_color_code_for(color_type)
        ANSI_COLOR_CODE_BY_COLOR_TYPE[configured_color_name_for(color_type)] || ANSI_COLOR_CODE_BY_COLOR_TYPE[:white]
      end

      # @param color_type [Symbol]
      # @return [Symbol, nil]
      def configured_color_name_for(color_type)
        ::Petitest.configuration.color_scheme[color_type]
      end

      # @param string [String]
      # @param color_type [Symbol]
      # @return [String]
      def colorize(string, color_type)
        if ::Petitest.configuration.colored
          "\e[#{ansi_color_code_for(color_type)}m#{string}\e[0m"
        else
          string
        end
      end

      # @param string [String]
      # @param level [Integer]
      # @return [String]
      def indent(string, level)
        string.gsub(/^(?!$)/, " " * level)
      end
    end
  end
end
