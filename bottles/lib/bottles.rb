class Bottles
      def song
        verses(99, 0)
      end

      def verses(upper, lower)
        upper.downto(lower).map { |i| verse(i) }.join("\n")
      end

      def verse(number)
        case number
        when 0
          "No more bottles of beer on the wall, no more bottles of beer.\n" \
            "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
        else
          "#{number} #{container(number)} of beer on the wall, " \
            "#{number} #{container(number)} of beer.\n" \
            "Take #{noun(number)} down and pass it around, #{remainder(number)} #{container(number-1)} of beer on the wall.\n"
        end
      end

      # TODO: quantity
      def remainder(number=:FIXME)
        if number == 1
          "no more"
        else
          number - 1
        end        
      end

      def container(number)
        if number == 1
          "bottle"
        else
          "bottles"
        end
      end

      # TODO: pronoun
      def noun(number)
        if number == 1
          "it"
        else
          "one"
        end
      end

    end
