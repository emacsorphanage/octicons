#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'erb'

class Font
  attr_accessor :name, :url, :codepoint
end

url = 'http://octicons.github.com/'
doc = Nokogiri::HTML.parse(open(url))

fonts = []
doc.css('a.select-menu-item').each do |e|
  font = Font.new
  font.name = e.attribute('data-name')
  font.url = URI.join(url, e.attribute('href'))
  fonts << font
end

fonts.each do |font|
  $stderr.puts "Download #{font.name}"
  content = open(font.url).read()
  if content =~ /Unicode: (\w+)/
    font.codepoint = "\\x" + Regexp.last_match[1]
  end
  sleep 1
end

template =<<EOS
;; This file is generated automatically. Don't change this file !!
(defvar octicons-alist
'(
<% fonts.each do |font| %>
("<%= font.name %>" . "<%= font.codepoint %>") <% end %>
))

(provide 'octicons-data)
EOS

erb = ERB.new(template)
puts erb.result(binding)
