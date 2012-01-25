#
# b4f API Client
#

require 'rest-client'
require 'json'
require 'uri/common'

require 'rsty/output'

require "rexml/document"
include REXML

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
    return content
  end
end

class ApiClient

  def initialize(config,mediaType = MediaTypeJson.new)
    @base_url = config[:base_url]
    @user = config[:user]
    @password = config[:password]

    @mediaType = mediaType
    @base_params =  {:api_key => 12}
#    RestClient.proxy = 'http://localhost:8888'
  end

  def execute(method,path,args = {},outputter = VerboseOutput.new)

    args.merge! @base_params

    if [:get,:delete].include? method
      url = to_url(path,args)
    else
      url = to_url(path)
      payload = args
    end

    req = RestClient::Request.new(
        :method => method, 
        :url => url,
        :user => @user, 
        :password => @password, 
        :headers => { 
          :accept => @mediaType.accept() 
        },
        :payload => payload
      )
    res = extract_response do 
      req.execute()
    end

    outputter.output req,res,@mediaType
  end

  def extract_response (&block)
    begin
      return yield block
    rescue RestClient::ExceptionWithResponse => e
      return e.response
    end
  end

  def get(path,args = {})
    execute(:get, path,args)
  end

  def post(path,args = {})
    execute(:post, path,args)
  end

  def delete(path,args = {})
    execute(:delete, path, args)
  end

  def to_url(path,args = {})
    res = ''
    res << @base_url 
    res <<  path
    if(args.length > 0)
      res << '?' << args.collect{|k,v| URI.escape(k.to_s) + '=' + URI.escape(v.to_s) }.join('&')
    end
    return res
  end
end
end