require_relative '../phase6/controller_base'
require_relative './csrf'

module Phase7
  class ControllerBase < Phase7::ControllerBase
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

  end
end
