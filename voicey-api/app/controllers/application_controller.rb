class ApplicationController < ActionController::API

    # import HttpAuthentication library from ActionController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    # require authentication for all controller in our app
    before_action :require_login

    # this will be used/called when we need authentication
    def require_login
        authorize_request || render_unathorized("Access denied")
    end

    # helper method to find the current_user in a request
    def current_user
        @current_user ||= authorize_request
    end

    # renders a message when a user is unauthorized
    def render_unathorized(message)
        errors = { errors: [ { detail: message } ] }
        render json: errors, status: :unauthorized
    end

    private

    # authenticate a user with by token
    def authorize_request
        authenticate_with_http_token do |token, options|
            User.find_by(token: token)
        end
    end


end
