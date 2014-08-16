require_relative "css_reader"
require_relative "theme_analyzer"

ARGV.each do |file|
	analyzer = ThemeAnalyzer.new(file)
	analyzer.read
	analyzer.generate
end