Rails.application.routes.draw do
  devise_for :users

  root "documents#index"

  resources :documents do
    member do
      get :pdf
      get :email_pdfs
    end
  end

  resources :lists

  get "up" => "rails/health#show", as: :rails_health_check
end
