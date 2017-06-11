Rails.application.routes.draw do
  get "/people" => "people#index"
  post "/people" => "people#create"
  delete "/people" => "people#destroy"
  root 'people#index'
end
