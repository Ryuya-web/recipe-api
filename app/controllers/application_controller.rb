class ApplicationController < ActionController::Base
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :json_parse_errors

  def json_parse_errors
    render json: {
      "message": "Recipe creation failed!",
     }
  end
end
