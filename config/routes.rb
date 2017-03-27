# == Route Map
#
#                          Prefix Verb   URI Pattern                                          Controller#Action
#                      staff_root GET    /staff(.:format)                                     staff/top#index {:host=>"0.0.0.0"}
#                     staff_login GET    /staff/login(.:format)                               staff/sessions#new {:host=>"0.0.0.0"}
#                   staff_session DELETE /staff/session(.:format)                             staff/sessions#destroy {:host=>"0.0.0.0"}
#                                 POST   /staff/session(.:format)                             staff/sessions#create {:host=>"0.0.0.0"}
#           confirm_staff_account PATCH  /staff/account/confirm(.:format)                     staff/accounts#confirm {:host=>"0.0.0.0"}
#              edit_staff_account GET    /staff/account/edit(.:format)                        staff/accounts#edit {:host=>"0.0.0.0"}
#                   staff_account GET    /staff/account(.:format)                             staff/accounts#show {:host=>"0.0.0.0"}
#                                 PATCH  /staff/account(.:format)                             staff/accounts#update {:host=>"0.0.0.0"}
#                                 PUT    /staff/account(.:format)                             staff/accounts#update {:host=>"0.0.0.0"}
#             edit_staff_password GET    /staff/password/edit(.:format)                       staff/passwords#edit {:host=>"0.0.0.0"}
#                  staff_password GET    /staff/password(.:format)                            staff/passwords#show {:host=>"0.0.0.0"}
#                                 PATCH  /staff/password(.:format)                            staff/passwords#update {:host=>"0.0.0.0"}
#                                 PUT    /staff/password(.:format)                            staff/passwords#update {:host=>"0.0.0.0"}
#                 staff_customers GET    /staff/customers(.:format)                           staff/customers#index {:host=>"0.0.0.0"}
#                                 POST   /staff/customers(.:format)                           staff/customers#create {:host=>"0.0.0.0"}
#              new_staff_customer GET    /staff/customers/new(.:format)                       staff/customers#new {:host=>"0.0.0.0"}
#             edit_staff_customer GET    /staff/customers/:id/edit(.:format)                  staff/customers#edit {:host=>"0.0.0.0"}
#                  staff_customer GET    /staff/customers/:id(.:format)                       staff/customers#show {:host=>"0.0.0.0"}
#                                 PATCH  /staff/customers/:id(.:format)                       staff/customers#update {:host=>"0.0.0.0"}
#                                 PUT    /staff/customers/:id(.:format)                       staff/customers#update {:host=>"0.0.0.0"}
#                                 DELETE /staff/customers/:id(.:format)                       staff/customers#destroy {:host=>"0.0.0.0"}
#           entries_staff_program PATCH  /staff/programs/:id/entries(.:format)                staff/programs#entries {:host=>"0.0.0.0"}
#                  staff_programs GET    /staff/programs(.:format)                            staff/programs#index {:host=>"0.0.0.0"}
#                                 POST   /staff/programs(.:format)                            staff/programs#create {:host=>"0.0.0.0"}
#               new_staff_program GET    /staff/programs/new(.:format)                        staff/programs#new {:host=>"0.0.0.0"}
#              edit_staff_program GET    /staff/programs/:id/edit(.:format)                   staff/programs#edit {:host=>"0.0.0.0"}
#                   staff_program GET    /staff/programs/:id(.:format)                        staff/programs#show {:host=>"0.0.0.0"}
#                                 PATCH  /staff/programs/:id(.:format)                        staff/programs#update {:host=>"0.0.0.0"}
#                                 PUT    /staff/programs/:id(.:format)                        staff/programs#update {:host=>"0.0.0.0"}
#                                 DELETE /staff/programs/:id(.:format)                        staff/programs#destroy {:host=>"0.0.0.0"}
#          inbound_staff_messages GET    /staff/messages/inbound(.:format)                    staff/messages#inbound {:host=>"0.0.0.0"}
#         outbound_staff_messages GET    /staff/messages/outbound(.:format)                   staff/messages#outbound {:host=>"0.0.0.0"}
#          deleted_staff_messages GET    /staff/messages/deleted(.:format)                    staff/messages#deleted {:host=>"0.0.0.0"}
#            count_staff_messages GET    /staff/messages/count(.:format)                      staff/messages#count {:host=>"0.0.0.0"}
#               tag_staff_message POST   /staff/messages/:id/tag(.:format)                    staff/messages#tag {:host=>"0.0.0.0"}
#                                 DELETE /staff/messages/:id/tag(.:format)                    staff/messages#tag {:host=>"0.0.0.0"}
#     confirm_staff_message_reply POST   /staff/messages/:message_id/reply/confirm(.:format)  staff/replies#confirm {:host=>"0.0.0.0"}
#         new_staff_message_reply GET    /staff/messages/:message_id/reply/new(.:format)      staff/replies#new {:host=>"0.0.0.0"}
#             staff_message_reply POST   /staff/messages/:message_id/reply(.:format)          staff/replies#create {:host=>"0.0.0.0"}
#                  staff_messages GET    /staff/messages(.:format)                            staff/messages#index {:host=>"0.0.0.0"}
#                   staff_message GET    /staff/messages/:id(.:format)                        staff/messages#show {:host=>"0.0.0.0"}
#                                 DELETE /staff/messages/:id(.:format)                        staff/messages#destroy {:host=>"0.0.0.0"}
#      inbound_staff_tag_messages GET    /staff/tags/:tag_id/messages/inbound(.:format)       staff/messages#inbound {:host=>"0.0.0.0"}
#     outbound_staff_tag_messages GET    /staff/tags/:tag_id/messages/outbound(.:format)      staff/messages#outbound {:host=>"0.0.0.0"}
#      deleted_staff_tag_messages GET    /staff/tags/:tag_id/messages/deleted(.:format)       staff/messages#deleted {:host=>"0.0.0.0"}
#              staff_tag_messages GET    /staff/tags/:tag_id/messages(.:format)               staff/messages#index {:host=>"0.0.0.0"}
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
#    delete_admin_allowed_sources DELETE /admin/allowed_sources/delete(.:format)              admin/allowed_sources#delete {:host=>"0.0.0.0"}
#           admin_allowed_sources GET    /admin/allowed_sources(.:format)                     admin/allowed_sources#index {:host=>"0.0.0.0"}
#                                 POST   /admin/allowed_sources(.:format)                     admin/allowed_sources#create {:host=>"0.0.0.0"}
#                   customer_root GET    /                                                    customer/top#index {:host=>"0.0.0.0"}
#          customer_article_index GET    /article/index(.:format)                             customer/article#index {:host=>"0.0.0.0"}
#         customer_campaign_index GET    /campaign/index(.:format)                            customer/campaign#index {:host=>"0.0.0.0"}
#        customer_campaign_submit GET    /campaign_submit(.:format)                           customer/campaign#submit {:host=>"0.0.0.0"}
#                  customer_login GET    /login(.:format)                                     customer/sessions#new {:host=>"0.0.0.0"}
#                customer_session DELETE /session(.:format)                                   customer/sessions#destroy {:host=>"0.0.0.0"}
#                                 POST   /session(.:format)                                   customer/sessions#create {:host=>"0.0.0.0"}
#        confirm_customer_account PATCH  /account/confirm(.:format)                           customer/accounts#confirm {:host=>"0.0.0.0"}
#           edit_customer_account GET    /account/edit(.:format)                              customer/accounts#edit {:host=>"0.0.0.0"}
#                customer_account GET    /account(.:format)                                   customer/accounts#show {:host=>"0.0.0.0"}
#                                 PATCH  /account(.:format)                                   customer/accounts#update {:host=>"0.0.0.0"}
#                                 PUT    /account(.:format)                                   customer/accounts#update {:host=>"0.0.0.0"}
#   cancel_customer_program_entry PATCH  /programs/:program_id/entries/:id/cancel(.:format)   customer/entries#cancel {:host=>"0.0.0.0"}
#        customer_program_entries POST   /programs/:program_id/entries(.:format)              customer/entries#create {:host=>"0.0.0.0"}
#               customer_programs GET    /programs(.:format)                                  customer/programs#index {:host=>"0.0.0.0"}
#                customer_program GET    /programs/:id(.:format)                              customer/programs#show {:host=>"0.0.0.0"}
#       confirm_customer_messages POST   /messages/confirm(.:format)                          customer/messages#confirm {:host=>"0.0.0.0"}
#               customer_messages GET    /messages(.:format)                                  customer/messages#index {:host=>"0.0.0.0"}
#                                 POST   /messages(.:format)                                  customer/messages#create {:host=>"0.0.0.0"}
#            new_customer_message GET    /messages/new(.:format)                              customer/messages#new {:host=>"0.0.0.0"}
#                            root GET    /                                                    errors#routing_error
#                                 GET    /*anything(.:format)                                 errors#routing_error
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
      resource :account, only: [:show, :edit, :update] do
        patch :confirm
      end
      resource :password, only: [:show, :edit, :update]
      resources :customers
      resources :programs do
        patch :entries, on: :member
      end
      resources :messages, only: [ :index, :show, :destroy ] do
        get :inbound, :outbound, :deleted, :count, on: :collection
        post :tag, on: :member
        delete :tag, on: :member
        resource :reply, only: [ :new, :create ] do
          post :confirm
        end
      end
      resources :tags, only: [] do
        resources :messages, only: [ :index ] do
          get :inbound, :outbound, :deleted, on: :collection
        end
      end
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
      resources :allowed_sources, only: [ :index, :create ] do
        delete :delete, on: :collection
      end
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
      get 'article/index'
      get 'campaign/index'
      get 'campaign_submit', to: 'campaign#submit'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resources :programs, only: [ :index, :show ] do
        resources :entries, only: [ :create ] do
          patch :cancel, on: :member
        end
      end
      resources :messages, only: [ :index, :new, :create ] do
        post :confirm, on: :collection
      end
    end
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
