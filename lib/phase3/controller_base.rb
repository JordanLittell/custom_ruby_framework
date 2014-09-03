
require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
    	controller_name = self.class.to_s.underscore.split("_")
    	controller_name = controller_name.join("_")
    	template = ERB.new(File.read("views/#{controller_name}/#{template_name.to_s}.html.erb"))
    	render_content(template.result, "text/html")
    end
  end
end
