Rails.application.routes.draw do
  get "api/session"
  devise_for :users

  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session

  get "/doctor_sign_in", to: "sessions#new", as: :new_doctor_session
  post "/doctor_sign_in", to: "sessions#create", as: :doctor_session
  match "/doctor_sign_out", to: "sessions#destroy", via: [:get, :delete], as: :destroy_doctor_session

  get "/patient_sign_in", to: "sessions#new", as: :new_patient_session
  post "/patient_sign_in", to: "sessions#create", as: :patient_session
  match "/patient_sign_out", to: "sessions#destroy_patient", via: [:get, :delete], as: :destroy_patient_session
  get "patient_dashboard/:id", to: "patients#dashboard", as: :patient_dashboard

  get "doctor_dashboard/:id", to: "doctors#dashboard", as: :doctor_dashboard
  get "doctor_patients", to: "doctors#patients", as: :doctor_patients
 resources :prescriptions, only: [:create, :destroy,:edit, :update]
    root "hospitals#index"
  authenticated :user do
    root "hospitals#index", as: :authenticated_root
  end

  unauthenticated do
    root "sessions#new", as: :unauthenticated_root
  end

  resources :hospitals do
    resource :profile
      member do
    patch :upload_image
    delete :remove_image
  end

    resources :doctors
    resources :patients
    resources :appointments do
      member do
        patch :update_status
      end
    end
  end
namespace :api do
  post "login", to: "sessions#create"

  resources :doctors, only: [:index, :show]
  resources :hospitals, only: [:index]
end

end


