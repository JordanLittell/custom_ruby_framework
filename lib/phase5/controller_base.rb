require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
    	@params = Params.new(req, route_params)	
    	p self.params
    	super(req,res)
    	p self.params
    end

  end
end

