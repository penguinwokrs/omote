# frozen_string_literal: true
class Mocks::AuthenticationController < ApplicationController
  def new; end

  def create
    authentication = Authentication.new(set_authentication_params.merge(review_token: params[:review_token]))
    if authentication.save
      # FIXME: どこに飛ばすか
      redirect_to new_mocks_authentication_path
    else
      render :new
    end
  end

  private

  def set_authentication_params
    params.require(:authentication).permit(:name, :prefecture_id, :address, :dob, :token)
  end
end
