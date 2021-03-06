require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do

  input = params['input']
  shift = params['shift'].to_i
  output = caesar_cipher(input, shift)
  erb :index, :locals => {:output => output}
end

def caesar_cipher(input_string, number_shift)
  if input_string.nil? or number_shift.nil?
    return nil
  end
  output_array = []
  input_string.scan(/./) do |match| 
    if match >= "A" && match <= "Z"
      shift_character = match.ord + number_shift
      if shift_character > 90
        shift_character = (shift_character % 90) + 64
      end
      output_array.push(shift_character.chr)
    elsif match >= "a" && match <= "z"
      shift_character = match.ord + number_shift
      if shift_character > 122
        shift_character = (shift_character % 122) + 96
      end
      output_array.push(shift_character.chr)
    else
      output_array.push(match)
    end
  end
  output_string = output_array.join("")
  output_string
end