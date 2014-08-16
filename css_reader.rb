class CssReader
  attr_accessor :colors
  def initialize
    @colors = {}
  end

  def sortedColors
    @colors.sort_by {|k,v| -v}
  end

  def parseLine(line)
    rgbTest = Regexp.new(/(\d{1,3})\s?,\s?(\d{1,3})\s?,\s?(\d{1,3})*/)
    hexTest = Regexp.new(/(?<=#)(?<!^)(\h{6}|\h{3})/)

    rgbMatches = rgbTest.match line
    hexMatches = hexTest.match line

    unless rgbMatches.nil?
      color = convertRgbToHex(rgbMatches[1], rgbMatches[2], rgbMatches[3]).upcase
      @colors.has_key?(color) ? @colors[color] += 1 : @colors[color] = 1
    end

    unless hexMatches.nil?
      color = expandHex(hexMatches[0]).upcase
      @colors.has_key?(color) ? @colors[color] += 1 : @colors[color] = 1
    end
  end

  def convertRgbToHex(r,g,b)
    sprintf('%02d', Integer(r).to_s(16)) + 
    sprintf('%02d', Integer(g).to_s(16)) +
    sprintf('%02d', Integer(b).to_s(16))
  end

  def expandHex(hex)
    if hex.length == 3
      hex[0] * 2 + hex[1] * 2 + hex[2] * 2
    else
      hex
    end
  end

end
