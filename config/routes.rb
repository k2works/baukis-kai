Rails.application.routes.draw do
  get 'errors/routing_error'

  namespace :staff do
    root 'top#index'
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
