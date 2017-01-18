# == Route Map
#
#                   Prefix Verb   URI Pattern                         Controller#Action
#     errors_routing_error GET    /errors/routing_error(.:format)     errors#routing_error
#               staff_root GET    /staff(.:format)                    staff/top#index
#              staff_login GET    /staff/login(.:format)              staff/sessions#new
#            staff_session POST   /staff/session(.:format)            staff/sessions#create
#                          DELETE /staff/session(.:format)            staff/sessions#destroy
#               admin_root GET    /admin(.:format)                    admin/top#index
#            customer_root GET    /customer(.:format)                 customer/top#index
#   customer_article_index GET    /customer/article/index(.:format)   customer/article#index
#  customer_campaign_index GET    /customer/campaign/index(.:format)  customer/campaign#index
# customer_campaign_submit GET    /customer/campaign_submit(.:format) customer/campaign#submit
#                     root GET    /                                   errors#routing_error
#                          GET    /*anything(.:format)                errors#routing_error
#

Rails.application.routes.draw do
  get 'errors/routing_error'

  namespace :staff do
    root   'top#index'
    get    'login'   => 'sessions#new', as: :login
    post   'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
  end

  namespace :admin do
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
    get 'article/index'
    get 'campaign/index'
    get 'campaign_submit', to: 'campaign#submit'
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
