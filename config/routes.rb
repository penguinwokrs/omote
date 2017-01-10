Rails.application.routes.draw do

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'main#index'

get '/main' => 'main#index'
get '/menu' => 'main#menu'
get '/procedure' => 'main#procedure'
get '/gift' => 'main#gift'
get '/blog' => 'main#blog'
get '/blog/:id' => 'main#blog_contents'
get '/reservation' => 'main#reservation'


get '/about' => 'main#about'
get '/event' => 'main#event'
get '/giver' => 'main#giver'
get '/interview' => 'main#interview'
get '/media' => 'main#media'
get '/review' => 'main#review'


get '/faq' => 'main#faq'
get '/contact' => 'main#contact'
get '/policy' => 'main#policy'
get '/recruit_giver' => 'main#recruit_giver'
get '/recruit' => 'main#recruit'
get '/company' => 'main#company'

end
