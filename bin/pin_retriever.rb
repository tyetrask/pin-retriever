#!/usr/bin/env ruby

bin_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(bin_path, ".."))
require 'lib/pin_retriever'

token_argument = nil
output_path_argument = nil

begin
  arguments = ARGV
  token_argument_index = arguments.index("-t") + 1
  output_path_argument_index = arguments.index("-o") + 1
  token_argument = arguments[token_argument_index]
  output_path_argument = arguments[output_path_argument_index]
rescue
  puts "Arguments supplied were invalid"
  exit
end

pin_retriever = PinRetriever.new(token_argument, output_path_argument)
pin_retriever.download_pin_images!
