Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    get '/departments', to: 'department#index', as: 'departments'
    get '/metrics/:type/:year', to: 'metric#by_type_and_year'
    get '/metrics/:type', to: 'metric#by_type'
    get '/metrics', to: 'metric#index', as: 'metrics'
  end
end
