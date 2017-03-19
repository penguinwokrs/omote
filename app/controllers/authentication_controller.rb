# frozen_string_literal: true
class AuthenticationController < ApplicationController
  protect_from_forgery except: :update_from_trust_dock
  before_action :valid_request,
                :set_authentication_by_trust_dock_id,
                only: :update_from_trust_dock

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.find_or_initialize_by(
      set_authentication_params.to_h.merge(multi_parameter_attribute)
    )
    @authentication.review_token = params[:review_token]
    (render(:new) && return) unless @authentication.save(
      context: :request_authentication
    )
  end

  def update_from_trust_dock
    response_service =
      TrustDock::Callbacks::RequestAuthentication.new(
        authentication: @authentication,
        params: params
      )
    response_service.update
    head :ok
  end

  private

  def set_authentication_params
    params.require(:authentication)
          .permit(:name, :gender, :prefecture_id, :address)
  end

  def set_authentication_by_trust_dock_id
    @authentication = Authentication.find_by(trust_dock_id: params['id'])
    head :not_found if @authentication.blank?
  end

  def multi_parameter_attribute
    date = params.require(:authentication)
                 .permit(:dob).to_h.map do |key, value|
      type_cast_attribute_value(key, value)
    end

    { dob: Date.new(date[0], date[1], date[2]) }
  rescue
    { dob: nil }
  end

  def type_cast_attribute_value(multiparameter_name, value)
    if multiparameter_name =~ /\([0-9]*([if])\)/
      value.send('to_' + Regexp.last_match(1))
    else
      value
    end
  end

  def valid_request
    return if Rails.env.development?
    trust_dock = TrustDock::DigitalSignature.new(request)
    result = trust_dock.secure_compare
    if result[:stauts] == 500
      render(text: result[:message], status: 500) && return
    end
    head(:ok) && (return false) if params[:message] == 'Ping'
  end
end
