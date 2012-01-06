Stack::Application.routes.draw do
  devise_for :users

  resources :groups, :only => [:index, :show], :path => 'grupy' do
    resources :containers, :path => 'pojemniki', :path_names => { :new => 'nowy', :edit => 'edytuj' }
    resources :teams, :path => 'zespoly', :path_names => { :new => 'nowy', :edit => 'edytuj' }
    resources :posts, :path => 'posty' do
      resources :comments, :path => 'komentarze'
      resources :attachments, :path => 'pliki'
    end
  end

  resource :dashboard, :path => 'kokpit'

  root :to => 'welcome#index'
end
