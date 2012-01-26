require 'json'
require 'nokogiri'

module Rsty
  class MediaTypeJson
    def accept()
      return 'application/json'
    end

    def pretty_print(content)
      data = JSON.parse(content)
      return JSON.pretty_generate(data)
    end
  end

  class MediaTypeXml
    def accept()
      return 'application/xml'
    end

    def pretty_print(content)
      xmlPrinter = XmlPrinter.new
      return xmlPrinter.print(content)      
    end
  end
  
  class XmlPrinter
    def print(xmlStr)
      doc = PrintDocument.new
      parser = Nokogiri::XML::SAX::Parser.new(doc)
      parser.parse(xmlStr)
      doc.to_s
    end
  end
  class PrintDocument < Nokogiri::XML::SAX::Document
    
    def initialize
      @buffer = StringIO.new
      @level = 0
      @last_text = false
      
      @color_element = :light_cyan
      @color_text = :yellow
      @color_markup = :light_green
    end
    
    def to_s
      @buffer.string
    end
    
    def indent
      return "  " * @level
    end
    
    def xmldecl(version, encoding, standalone)
      @buffer << "<?xml version=\"#{version}\" encoding=\"#{encoding}\" standalone=\"#{standalone}\"?>"
    end
    
    def start_element name, attrs = []
      # TODO attrs
      @buffer << "\n" << indent 
      @buffer << "<".colorize(@color_markup)
      @buffer << "#{name}".colorize(@color_element)
      if(attrs.size)
        @buffer << attrs.collect {|k,v| "#{k}=\"#{v}\""}.join(" ")
      end      
      @buffer << ">".colorize(@color_markup)
      @level += 1
    end
    
    def end_element(name)
      @level -= 1
      if(!@last_text)
        @buffer << "\n" << indent
      end
      @buffer << "</".colorize(@color_markup)  
      @buffer << "#{name}".colorize(@color_element)
      @buffer << ">".colorize(@color_markup)
      @last_text = false
    end
    
    def characters(string)
      @last_text= true
      @buffer << string.colorize(@color_text)
    end
  end      
end