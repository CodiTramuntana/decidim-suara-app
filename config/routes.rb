# frozen_string_literal: true

Rails.application.routes.draw do
  mount Decidim::Core::Engine => "/"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :consultations, param: :slug, only: [] do
      resources :participants, only: [] do
        get :exports, to: "consultations/participants#export", on: :collection
      end
    end
  end
end
