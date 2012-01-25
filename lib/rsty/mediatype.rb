require 'json'

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
end