Rails.application.routes.draw do
  mount Apidocs::Engine, :at => "/apidocs"
  resources :products
end
