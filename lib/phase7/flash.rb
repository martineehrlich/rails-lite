require 'json'
require 'webrick'

module Phase7
  class Flash
    attr_reader :now, :later
    def initialize(req)
      @now = {}
      @later = {}
      req.cookies.each do |cookie|
        if cookie.name == "_rails_lite_flash"
          @now = JSON.parse(cookie.value)
       end
     end
    end

    def [](key)
      @now[key.to_s] || @later[key.to_s]
    end

    def []=(key, val)
      @later[key.to_s] = val
    end

    def now
      @now
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      serialized_flash = @later.to_json
      res.cookies << WEBrick::Cookie.new("_rails_lite_flash" , serialized_flash)
    end

  end
end
