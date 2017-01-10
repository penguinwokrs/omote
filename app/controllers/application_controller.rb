class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	before_action :set

	def set
		@global_navi = GlobalNavi.all
		@footer = Footer.all
	end

end
