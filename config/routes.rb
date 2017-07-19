Rails.application.routes.draw do
  devise_for :users

  authenticated :user do

    get '/submissions' => 'submissions#index'

    get '/project_demos/latest' => 'project_demos#latest'
    resources :project_demos
    resources :projects

    post '/votes' => "votes#create", as: 'create_vote'
    delete '/votes' => "votes#delete", as: 'delete_vote'
  end

  get '/about' => 'home#about'
  root to: 'home#index'
end
