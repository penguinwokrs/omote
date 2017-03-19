# frozen_string_literal: true
class Mocks::AuthenticationController < ApplicationController
  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(
      set_authentication_params
      .merge(review_token: params[:review_token])
    )
    render :new && return unless @authentication.save
  end

  def update_from_trust_dock
    @authentication = Authentication.find(trust_dock_id: params['id'])
    response_service = ResponseService.new(@authentication, params)
    response_service.save
    render head: :ok
  end

  private

  def set_authentication_params
    params.require(:authentication)
          .permit(:name, :prefecture_id, :address, :dob, :token)
  end

  def set_authtication_by_trust_dock_id
    @authentication = Authentication.find_by(trust_dock_id: params['id'])
    raise ActiveRecordNotFound if @authentication.blank? # FIXME: 例外処理
  end
end
