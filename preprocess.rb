#!/usr/bin/env ruby

def warning(file)
    "\n<!-- this file includes generated content. Do not edit. Edit #{file}, instead. -->\n"
end

files = Dir["content/**/*generator.md"]
matcher = /<!--\s+write-here\s+"(?<path>[^"]+)"\s*-->(?<contents>.*?)<!--\s*end-write\s*-->/sum

for file in files do
    text = File.read(file)
    loop do
        match = text.match(matcher)
        break if match.nil?
        source = match[:path]
        text.gsub!(matcher, "#{warning(file)}\n#{File.read(source)}\n")
    end
    target_dir = File.dirname(file)
    File.write("#{target_dir}/_index.md", text)
end