class Bottles
  def initialize; end

  def verse(count)
    build_verse(count - 1)
  end

  def verses(count_end, count_start)
    count_end.downto(count_start).map { |count| build_verse(count - 1) }.join("\n")
  end

  def build_verse(count)
    if count > 1
      "#{count + 1} bottles of beer on the wall, " +
        "#{count + 1} bottles of beer.\n" +
        "Take one down and pass it around, " +
        "#{count} bottles of beer on the wall.\n"
    elsif count == 1
      "#{count + 1} bottles of beer on the wall, " +
        "#{count + 1} bottles of beer.\n" +
        "Take one down and pass it around, " +
        "#{count} bottle of beer on the wall.\n"
    elsif count == 0
      "#{count + 1} bottle of beer on the wall, " +
        "#{count + 1} bottle of beer.\n" +
        "Take it down and pass it around, " +
        "no more bottles of beer on the wall.\n"
    elsif count < 0
      "No more bottles of beer on the wall, " +
        "no more bottles of beer.\n" +
        "Go to the store and buy some more, " +
        "99 bottles of beer on the wall.\n"
    end
  end
end
