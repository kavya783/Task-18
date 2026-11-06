Rails.application.routes.draw do
  # ROOT ROUTE
   root to: redirect("/sign_in")
  # ACTIVE ADMIN
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # DEVISE USER AUTHENTICATION
  devise_for :users, controllers: {
  registrations: "devise/registrations"
}
  # WEB AUTHENTICATION ROUTES
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create"
  match "/sign_out", to: "sessions#destroy", via: [:get, :delete]

  get "/doctor_sign_in", to: "sessions#new"
  post "/doctor_sign_in", to: "sessions#create"
  match "/doctor_sign_out", to: "sessions#destroy", via: [:get, :delete]

  get "/patient_sign_in", to: "sessions#new"
  post "/patient_sign_in", to: "sessions#create"
  delete "/patient_sign_out",
         to: "sessions#destroy_patient",
         as: :patient_sign_out
  # HOSPITAL WEB ROUTES
  resources :hospitals do
    resources :doctors
    resources :patients
    resources :appointments do
      member do
        patch :update_status
      end
    end
    member do
      delete :remove_image
      patch :upload_image
    end
  end
  # DASHBOARD ROUTES
  get "patient_dashboard/:id",
      to: "patients#dashboard",
      as: :patient_dashboard
  get "doctor_dashboard/:id",
      to: "doctors#dashboard",
      as: :doctor_dashboard
  get "doctor_patients",
      to: "doctors#patients",
      as: :doctor_patients  
  resources :prescriptions, only: [:create, :update, :destroy]
  # API ROUTES
  namespace :api do
    namespace :v1 do
      # AUTHENTICATION
      post "login", to: "auth#login"
      post "hospital/signup", to: "hospital_auth#signup"
      post "doctor/signup", to: "doctor_auth#signup"
      post "patient/signup", to: "patient_auth#signup"

      # HOSPITAL CONTEXT
      resources :hospitals do
        resources :doctors
        resources :patients
        resources :appointments
      end

      # DOCTOR CONTEXT
      get "doctor/patients", to: "patients#my_patients"
      get "doctor/appointments", to: "appointments#doctor_appointments"
      get "doctor/prescriptions", to: "prescriptions#doctor_prescriptions"

      # PATIENT CONTEXT
      get "patient/doctor", to: "patients#my_doctor"
      get "patient/appointments", to: "appointments#patient_appointments"
      get "patient/prescriptions", to: "prescriptions#patient_prescriptions"

    end
  end
end
