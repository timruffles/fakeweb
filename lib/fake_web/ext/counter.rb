module FakeWeb
  
  @count_registry = {}
  class << self
    attr_accessor :count_registry
    def call_count_for(uri)
      count_registry[normalise(uri)] || 0
    end

    def uri_called(uri)
      uri = normalise(uri)
      count_registry[uri] ||= 0
      count_registry[uri] += 1
    end

    def reset_call_count_for(uri)
      count_registry[normalise(uri)] = 0
    end
    
    def normalise uri
      uri = URI.parse(uri)
      uri.host
    end
    
  end
end