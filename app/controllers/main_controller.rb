class MainController < ApplicationController

def index
		@menu = Menu.all
end

def menu
	@menu = Menu.all
end

def faq
	@about = Faq.where(category: "Omoteとは？")
	@service = Faq.where(category: "サービスについて")
	@register = Faq.where(category: "会員登録について")
	@giver = Faq.where(category: "Giver と Taker")
	@price = Faq.where(category: "料金について")
	@procedure = Faq.where(category: "予約お申込みから当日まで")
	@cancel = Faq.where(category: "キャンセルについて")
end

def blog
	@blogs = Blog.all
end

def blog_contents
	@blog = Blog.find_by(id: params[:id])
	@blogs = Blog.all

end

def media
	@pr = Medium.where(category: "PressRelease&News")
	@media = Medium.where(category: "Media")
end

def review
	@review = Review.all
end

def interview
end

end
