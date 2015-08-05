require_relative '../phase6/controller_base'
require_relative './flash'

module Phase7
  class ControllerBase < Phase6::ControllerBase
    attr_reader :auth_token
    def initialize(*args)
      super
      check_for_forgery
    end

    def redirect_to(url)
      super
      flash.store_flash(self.res)
    end

    def render_content(content, content_type)
      super(content, content_type)
      flash.store_flash(self.res)
    end

    def flash
      @flash ||= Flash.new(self.req)
    end

    def add_session_token
      @auth_token = SecureRandom.urlsafe_base64
      session['auth_token'] = auth_token
    end

    def check_for_forgery
      debugger
      if req.request_method == 'POST' && params["auth_token"] != session["auth_token"]
        raise 'Invalid authenticity token'
      end
      add_session_token
    end
  end
end
