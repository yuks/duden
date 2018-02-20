#!/usr/bin/env ruby

# this script uses the list in words.txt to download every duden html page
# from https://www.duden.de/rechtschreibung/* to data/.
# Warning, don't do it all at once :)

require 'nokogiri'
require 'open-uri'
require 'fileutils'

words = File.readlines('words.txt')

for word in words
    puts word
    word = word.gsub("\n",'')
    doc = Nokogiri::HTML(open("https://www.duden.de/rechtschreibung#{word}"))
    content = doc.css("main#content")
    dirname = "data/"
    file_name = "#{word}.html"
    FileUtils.mkdir_p(dirname) unless Dir.exists?(dirname)
    file = File.open(File.join(Dir.pwd, dirname, file_name),"w+")
    file.puts content
    file.close
end
