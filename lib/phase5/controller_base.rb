require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params


    def initialize(req, res, route_params = {})
      @req = req
      @res = res
      @params = Params::new(req, route_params)
    end
  end
end
