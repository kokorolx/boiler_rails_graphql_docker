# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  default_url_options host: ENV['DEFAULT_URL']

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/graphql', to: 'graphql#execute'
  devise_for :users,
             controllers: {
               confirmations: 'auth/confirmations',
               passwords: 'auth/passwords',
               invitations: 'auth/invitations'
             },
             skip: :registrations # skip registration route


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Just a blank root path
  root 'pages#blank'
end
