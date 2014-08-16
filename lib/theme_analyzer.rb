class ThemeAnalyzer

  def initialize(filename)
    @filename = filename
    @reader = CssReader.new
  end

  def read
    file = File.open(@filename)
    file.each_line do |line|
      @reader.parseLine(line)
    end
  end

  def getOutputName(filename)
    "#{filename.split('.')[0]}Output.html"
  end

  def getColors
    @reader.sortedColors.select {|k,v| k.length < 7}
  end

  def generate
    File.open(getOutputName(@filename), 'w') { |file|
      file.write "<!DOCTYPE html><html><head><link rel='stylesheet' href='bs.css'></head><body>"
      getColors.each_slice(4) do |batch|
        file.write "<div style='margin:10px;padding:10px;border-bottom: 1px solid #999' class='row'>"
        batch.each do |color, occurences|
          writeColor(file, color, occurences)
        end
        file.write "</div>"
      end
      file.write "</body></html>"
    }
  end

  def writeColor(file, color, occurences)
    file.write "
    <div class='col-md-3'>
      <h4>You used the color #{color} #{occurences} times</h4>
      <button class='btn' 
      style='border:1px solid black;width:100px;height:50px;
      background:#"+color+"'></button>
    </div>"
  end
end