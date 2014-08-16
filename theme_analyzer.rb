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
		filename.split('.')[0]
	end

	def getColors
		colors = @reader.sortedColors
		colors = colors.select { |key, value| key.length < 7}	
		colors
	end

	def generate
		File.open("#{getOutputName(@filename)}Output.html", 'w') { |file|
			file.write "<!DOCTYPE html><html><head>"
			file.write "<link rel='stylesheet' href='bs.css'>"
			file.write "</head><body>"
			i = 0
			getColors.each do |color, occurences|
				if i % 4 == 0
					file.write "<div style='margin:10px;padding:10px;border-bottom: 1px solid #999' class='row'>"
				end
				file.write "<div class='col-md-3'>"
				file.write "<h4>You used the color #{color} #{occurences} times</h4>
				<button class='btn' style='border:1px solid black;width:100px;height:50px;background:#"+color+"'></button>
				</div>"
				if i % 4 == 3
					file.write "</div>"
				end

				i += 1
			end
			file.write "</body></html>"
		}
	end
end