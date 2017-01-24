# == Route Map
#
#                   Prefix Verb   URI Pattern                   Controller#Action
#               staff_root GET    /staff(.:format)              staff/top#index {:host=>"0.0.0.0"}
#              staff_login GET    /staff/login(.:format)        staff/sessions#new {:host=>"0.0.0.0"}
#            staff_session DELETE /staff/session(.:format)      staff/sessions#destroy {:host=>"0.0.0.0"}
#                          POST   /staff/session(.:format)      staff/sessions#create {:host=>"0.0.0.0"}
#        new_staff_account GET    /staff/account/new(.:format)  staff/accounts#new {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#       edit_staff_account GET    /staff/account/edit(.:format) staff/accounts#edit {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#            staff_account GET    /staff/account(.:format)      staff/accounts#show {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#                          PATCH  /staff/account(.:format)      staff/accounts#update {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#                          PUT    /staff/account(.:format)      staff/accounts#update {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#                          DELETE /staff/account(.:format)      staff/accounts#destroy {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#                          POST   /staff/account(.:format)      staff/accounts#create {:host=>"0.0.0.0", :execpt=>[:new, :create, :destroy]}
#               admin_root GET    /admin(.:format)              admin/top#index {:host=>"0.0.0.0"}
#              admin_login GET    /admin/login(.:format)        admin/sessions#new {:host=>"0.0.0.0"}
#            admin_session DELETE /admin/session(.:format)      admin/sessions#destroy {:host=>"0.0.0.0"}
#                          POST   /admin/session(.:format)      admin/sessions#create {:host=>"0.0.0.0"}
#      admin_staff_members GET    /admin/staff(.:format)        admin/staff_members#index {:host=>"0.0.0.0"}
#                          POST   /admin/staff(.:format)        admin/staff_members#create {:host=>"0.0.0.0"}
#   new_admin_staff_member GET    /admin/staff/new(.:format)    admin/staff_members#new {:host=>"0.0.0.0"}
#            customer_root GET    /                             customer/top#index {:host=>"0.0.0.0"}
#   customer_article_index GET    /article/index(.:format)      customer/article#index {:host=>"0.0.0.0"}
#  customer_campaign_index GET    /campaign/index(.:format)     customer/campaign#index {:host=>"0.0.0.0"}
# customer_campaign_submit GET    /campaign_submit(.:format)    customer/campaign#submit {:host=>"0.0.0.0"}
#                     root GET    /                             errors#routing_error
#                          GET    /*anything(.:format)          errors#routing_error
#

Rails.application.routes.draw do
  config = Rails.application.config.baukis_kai

  concern :session_path do
    get    'login'   => 'sessions#new', as: :login
    resource :session, only: [:create, :destroy]
  end

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root   'top#index'
      concerns :session_path
      resource :account, execpt: [:new, :create, :destroy]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path]  do
      root 'top#index'
      concerns :session_path
      resources :staff_members, only: [:index, :new, :create], path: 'staff'
    end
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
