Rails.application.routes.draw do
  get 'books/:id/income', to: "books#income"
  resources :users, only: [:create, :show] do
    member do
      get :reports
    end
  end
  resources :transactions, only: [] do
    collection do
      post :borrowing
      post :send_back
    end
  end
end
