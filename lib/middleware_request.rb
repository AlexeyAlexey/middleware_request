require 'middleware_request/id_and_params'

class MiddlewareRequest
  def initialize(app)
    @app = app
  end

  def call(env)
    RequestIdAndParams.new_current

    @status, @headers, @response = @app.call(env)

    [@status, @headers, @response]
  end
end

