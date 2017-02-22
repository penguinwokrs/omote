# frozen_string_literal: true
class Mocks::AuthenticationController < ApplicationController
  def new; end

  def create
    render text: '作成中です'
  end
end
