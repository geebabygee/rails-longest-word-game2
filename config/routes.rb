Rails.application.routes.draw do
  get '/', to: 'games#new'
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
