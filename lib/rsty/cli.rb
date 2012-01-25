module Rsty
  
  require 'optparse'
  require 'ostruct'
  require 'json'
  
  class Cli
    def exec(argv)
      options = OpenStruct.new
      options.output = Rsty::VerboseOutput.new
      options.mediaType = Rsty::MediaTypeJson.new
      options.configFile = 'rsty.json'

      opts = OptionParser.new do |opts|
        opts.banner = 'usage: rsty [OTPIONS] METHOD PATH'
        opts.separator ""
        opts.separator "Arguments:"
        opts.separator "  METHOD    The HTTP Method."
        opts.separator "  PATH      The base_url from the config and this PATH are the Request URL."
        opts.separator ""        
        opts.on('-s','--silent','Surpresses headers and just displays the body.') do
          options.output = Rsty::ContentOutput.new
        end

        opts.on('-q','--quite','Is quite. Prints nothing.') do
          options.output = Rsty::SilentOutput.new
        end

        opts.on('--xml','Queries the resource as appplication/xml') do
          options.mediaType = Rsty::MediaTypeXml.new
        end

        opts.on('--json','Queries the resource as application/json') do
          options.mediaType = Rsty::MediaTypeJson.new
        end

        opts.on('-c','--config CONFIG',
                "Specifies the config file. Default: '#{options.configFile}'") do |config|
          options.configFile = config
        end
      end

      opts.parse!(argv)

      if(argv.length < 2)
        puts "ERROR: wrong number of arguments"
        puts opts.banner
        return 1
      end

      if(!File.exists?(options.configFile))
        puts "config file #{options.configFile} does not exist."
        return 1
      end
      json = File.read(options.configFile)
      config = JSON.parse(json,:symbolize_names => true)
      api = Rsty::ApiClient.new(config,options.mediaType)

      method = ARGV.shift.downcase.to_sym
      path = ARGV.shift

      args = {}
      while ARGV.length > 0
        k , v = ARGV.shift.split('=')
        args[k] = v
      end

      api.execute method, path, args, options.output
      return 0
    end
  end
  
end