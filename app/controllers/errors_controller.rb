# frozen_string_literal: true
class ErrorsController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    raise request.env['action_dispatch.exception']
  end

  def not_found
    render :not_found, status: 404, layout: 'error'
  end

  def internal_server_error
    render :internal_server_error, status: 500, layout: 'error'
  end
end
