ScottBartell::Application.routes.draw do
  # Blog
  root to: 'pages#home'
  match '/posts.:format', to: 'posts#index'

  resources :tags, only: [:index, :show]

  match '/blog', to:'posts#index'

  # Static pages
  match '/about', to: 'pages#about', as: 'about'

  # Redirects
  match '/posts', to: redirect('/')
  match '/post/:permalink', to: redirect { |params, request| "/#{params[:permalink]}" }
  match '/posts/:permalink', to: redirect { |params, request| "/#{params[:permalink]}" }
  match '/blog/:page', to: redirect { |params, request| "/#{params[:page]}" }
  match '/archive.:format', to: redirect('/blog')
  match '/about-scott-bartell', to: redirect('/blog')

  # Admin
  namespace :admin do
    root to: 'admin#index'
    resources :posts, only: [:show, :new, :create, :update, :edit, :destroy, :index]
    resources :tags,  only: [:new, :create, :update, :edit, :destroy, :index]
  end

  # Pagination
  match '/:page', to: 'posts#index', as: 'blog_page', constraints: { page: /[0-9]+/}

  # Post
  get ':permalink', to: 'posts#show', as: 'post'
end
