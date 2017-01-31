# == Route Map
#
#                          Prefix Verb   URI Pattern                                          Controller#Action
#                      staff_root GET    /staff(.:format)                                     staff/top#index {:host=>"0.0.0.0"}
#                     staff_login GET    /staff/login(.:format)                               staff/sessions#new {:host=>"0.0.0.0"}
#                   staff_session DELETE /staff/session(.:format)                             staff/sessions#destroy {:host=>"0.0.0.0"}
#                                 POST   /staff/session(.:format)                             staff/sessions#create {:host=>"0.0.0.0"}
#              edit_staff_account GET    /staff/account/edit(.:format)                        staff/accounts#edit {:host=>"0.0.0.0"}
#                   staff_account GET    /staff/account(.:format)                             staff/accounts#show {:host=>"0.0.0.0"}
#                                 PATCH  /staff/account(.:format)                             staff/accounts#update {:host=>"0.0.0.0"}
#                                 PUT    /staff/account(.:format)                             staff/accounts#update {:host=>"0.0.0.0"}
#                      admin_root GET    /admin(.:format)                                     admin/top#index {:host=>"0.0.0.0"}
#                     admin_login GET    /admin/login(.:format)                               admin/sessions#new {:host=>"0.0.0.0"}
#                   admin_session DELETE /admin/session(.:format)                             admin/sessions#destroy {:host=>"0.0.0.0"}
#                                 POST   /admin/session(.:format)                             admin/sessions#create {:host=>"0.0.0.0"}
# admin_staff_member_staff_events GET    /admin/staff/:staff_member_id/staff_events(.:format) admin/staff_events#index {:host=>"0.0.0.0"}
#             admin_staff_members GET    /admin/staff(.:format)                               admin/staff_members#index {:host=>"0.0.0.0"}
#                                 POST   /admin/staff(.:format)                               admin/staff_members#create {:host=>"0.0.0.0"}
#          new_admin_staff_member GET    /admin/staff/new(.:format)                           admin/staff_members#new {:host=>"0.0.0.0"}
#         edit_admin_staff_member GET    /admin/staff/:id/edit(.:format)                      admin/staff_members#edit {:host=>"0.0.0.0"}
#              admin_staff_member GET    /admin/staff/:id(.:format)                           admin/staff_members#show {:host=>"0.0.0.0"}
#                                 PATCH  /admin/staff/:id(.:format)                           admin/staff_members#update {:host=>"0.0.0.0"}
#                                 PUT    /admin/staff/:id(.:format)                           admin/staff_members#update {:host=>"0.0.0.0"}
#                                 DELETE /admin/staff/:id(.:format)                           admin/staff_members#destroy {:host=>"0.0.0.0"}
#              admin_staff_events GET    /admin/staff_events(.:format)                        admin/staff_events#index {:host=>"0.0.0.0"}
#                   customer_root GET    /                                                    customer/top#index {:host=>"0.0.0.0"}
#          customer_article_index GET    /article/index(.:format)                             customer/article#index {:host=>"0.0.0.0"}
#         customer_campaign_index GET    /campaign/index(.:format)                            customer/campaign#index {:host=>"0.0.0.0"}
#        customer_campaign_submit GET    /campaign_submit(.:format)                           customer/campaign#submit {:host=>"0.0.0.0"}
#                            root GET    /                                                    errors#routing_error
#                                 GET    /*anything(.:format)                                 errors#routing_error
#

Rails.application.routes.draw do
  namespace :admin do
    get 'staff_events/index'
  end

  config = Rails.application.config.baukis_kai

  concern :session_path do
    get    'login'   => 'sessions#new', as: :login
    resource :session, only: [:create, :destroy]
  end

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root   'top#index'
      concerns :session_path
      resource :account, only: [:show, :edit, :update]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path]  do
      root 'top#index'
      concerns :session_path
      resources :staff_members, path: 'staff' do
        resources :staff_events, only: [:index]
      end
      resources :staff_events, only: [:index]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
      get 'article/index'
      get 'campaign/index'
      get 'campaign_submit', to: 'campaign#submit'
    end
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
