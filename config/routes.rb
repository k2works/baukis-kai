# == Route Map
#
#                   Prefix Verb   URI Pattern                     Controller#Action
#     errors_routing_error GET    /errors/routing_error(.:format) errors#routing_error
#               staff_root GET    /staff(.:format)                staff/top#index
#              staff_login GET    /staff/login(.:format)          staff/sessions#new
#            staff_session POST   /staff/session(.:format)        staff/sessions#create
#                          DELETE /staff/session(.:format)        staff/sessions#destroy
#        new_staff_account GET    /staff/account/new(.:format)    staff/accounts#new
#       edit_staff_account GET    /staff/account/edit(.:format)   staff/accounts#edit
#            staff_account GET    /staff/account(.:format)        staff/accounts#show
#                          PATCH  /staff/account(.:format)        staff/accounts#update
#                          PUT    /staff/account(.:format)        staff/accounts#update
#                          DELETE /staff/account(.:format)        staff/accounts#destroy
#                          POST   /staff/account(.:format)        staff/accounts#create
#               admin_root GET    /admin(.:format)                admin/top#index
#              admin_login GET    /admin/login(.:format)          admin/sessions#new
#            admin_session POST   /admin/session(.:format)        admin/sessions#create
#                          DELETE /admin/session(.:format)        admin/sessions#destroy
#      admin_staff_members GET    /admin/staff(.:format)          admin/staff_members#index
#                          POST   /admin/staff(.:format)          admin/staff_members#create
#   new_admin_staff_member GET    /admin/staff/new(.:format)      admin/staff_members#new
#            customer_root GET    /                               customer/top#index
#   customer_article_index GET    /article/index(.:format)        customer/article#index
#  customer_campaign_index GET    /campaign/index(.:format)       customer/campaign#index
# customer_campaign_submit GET    /campaign_submit(.:format)      customer/campaign#submit
#                     root GET    /                               errors#routing_error
#                          GET    /*anything(.:format)            errors#routing_error
#

Rails.application.routes.draw do
  get 'errors/routing_error'

  concern :session_path do
    get    'login'   => 'sessions#new', as: :login
    post   'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
  end

  namespace :staff do
    root   'top#index'
    concerns :session_path
    resource :account
  end

  namespace :admin do
    root 'top#index'
    concerns :session_path
    resources :staff_members, only: [:index, :new, :create], path: 'staff'
  end

  namespace :customer, path: '' do
    root 'top#index'
    get 'article/index'
    get 'campaign/index'
    get 'campaign_submit', to: 'campaign#submit'
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
