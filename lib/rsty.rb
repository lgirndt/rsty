module Rsty
  
  autoload :Cli,      'rsty/cli'
  
  autoload :ApiClient,      'rsty/apiclient'
  autoload :MediaTypeJson,  'rsty/apiclient'
  autoload :MediaTypeXml,   'rsty/apiclient'
  
  autoload :VerboseOutput,  'rsty/output'
  autoload :ContentOutput,  'rsty/output'
  autoload :SilentOutput,   'rsty/output'
end