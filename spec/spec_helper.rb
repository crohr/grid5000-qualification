# set the environment to use
ENV['API_URI'] ||= "https://api.grid5000.fr"

begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup(:default)
end    
Bundler.require(:default)

module URIHelper
  def uri_for(path)
    [
      ENV['API_URI'],
      path
    ].join("/")
  end
  
  %w{get head post put delete}.each do |method|
    define_method method.to_sym do |*args, &block|
      RestClient.send(method.to_sym, *args, &block)
    end
  end
  
  def parse(response)
    content_type = response.headers[:content_type]
    case content_type
    when /json/i
      JSON.parse response.body
    when /xml/i
      raise NotImplementedError, "Cannot parse #{content_type.inspect} content."
    else
      raise NotImplementedError, "Cannot parse #{content_type.inspect} content."
    end
  end
  
end

Spec::Runner.configure do |config|
  include URIHelper
  config.prepend_before do
    
  end
end
