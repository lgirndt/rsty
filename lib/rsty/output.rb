module Rsty
class VerboseOutput

  def output(req,res,printer)
    puts "Request:"
    puts "  URL: #{req.url}"
#    if(req.payload)
#      puts "Payload:"
#      req.payload.each {|k,v| puts "  #{k}:#{v}"}
#    end

    puts "Response:"
    res.headers.each {|k,v| puts "  HTTP-Header #{k}: #{v}"}
    puts "  HTTP Status Code: #{res.code}"    
    body = res.to_str
    puts "  Content Length: #{body.length} Bytes"
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