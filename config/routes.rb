Rails.application.routes.draw do
  devise_for :users
  
  resources :vloers, except: :show do
    member do
      get 'duplicate'
      get 'print'
    end
  end
  
  resources :regels, except: :show do
    member do
      get 'duplicate'
    end
  end
  
  resources :leveranciers, except: :show
  resources :articles, except: :show
  get 'vloers/find_pakbon'
  get 'regels/new_blanko'

  root 'vloers#index'
end
