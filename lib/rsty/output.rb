require 'colorize'

module Rsty
class VerboseOutput
  
  def initialize
    @key_color = :light_green
    @name_color = :light_cyan
    @value_color = :yellow 
  end

  def output(req,res,printer)
    puts "Request:".green
    puts "  URL: ".colorize(@key_color) + "#{req.url}".colorize(@value_color)
#    if(req.payload)
#      puts "Payload:"
#      req.payload.each {|k,v| puts "  #{k}:#{v}"}
#    end

    puts "Response:".green
    puts "  HTTP-Headers:".colorize(@key_color)
    res.headers.each do |k,v| 
      puts "    #{k}: ".colorize(@name_color) + "#{v}".colorize(@value_color)
    end
    puts "  HTTP Status Code: ".colorize(@key_color) + "#{res.code}".colorize(@value_color)
    body = res.to_str
    puts "  Content Length: ".colorize(@key_color) +"#{body.length} Bytes".colorize(@value_color)
    puts printer.pretty_print(body)
  end

end

class ContentOutput
  def output(req,res,printer)
    puts printer.pretty_print(res.to_str)
  end
end

class SilentOutput
  def output(req,res,printer)
    # noop
  end
end

end