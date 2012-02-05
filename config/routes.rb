Stack::Application.routes.draw do
  devise_for :users

  resources :groups, :only => [:index, :show], :path => 'grupy' do
    resources :containers, :path => 'pojemniki', :path_names => { :new => 'nowy', :edit => 'edytuj' } do
      post :upload
      resources :attachments, :path => 'pliki'
    end
    resources :teams, :path => 'zespoly', :path_names => { :new => 'nowy', :edit => 'edytuj' } do
      resources :posts, :path => 'posty', :path_names => { :new => 'nowy', :edit => 'edytuj' }
    end
    resources :posts, :path => 'posty' do
      resources :comments, :path => 'komentarze'
      resources :attachments, :path => 'pliki'
    end
  end

  resource :dashboard, :path => 'kokpit'

  root :to => 'welcome#index'
end
