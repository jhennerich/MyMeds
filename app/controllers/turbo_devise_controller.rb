# app/controllers/turbo_devise_controller.rb

class TurboDeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end

###
# code snip for logout to use with turbo and rails 7
#<%= button_to(
#  "Log Out",
#  destroy_user_session_path,
#  method: :delete
#) %>
