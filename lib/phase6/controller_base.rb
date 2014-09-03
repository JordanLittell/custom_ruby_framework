require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def initialize(res,req,route_params={})
    	super
    	puts 'made a controller'
    end


    def invoke_action(name)
    	return self.send(name) unless already_built_response?
    	render(name)
    end
  end
end
