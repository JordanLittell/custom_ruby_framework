module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller

    def initialize(req, res)
        @res = res 
        @req = req 
    end

    # Helper method to alias @already_built_response
    def already_built_response?
        @already_built_response || false
    end

    # Set the response status code and header
    def redirect_to(url)
        @res.status = 302
        @res.header["location"] = url
        raise StandardError.new("You already rendered") if @already_built_response
        @already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
        res.content_type = type
        res.body = content
        raise StandardError.new("You already rendered") if @already_built_response
        @already_built_response = true
    end


  end
end
