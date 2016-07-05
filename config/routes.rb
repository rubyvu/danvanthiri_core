DanvanthiriCore::Engine.routes.draw do
  devise_for :patient_coordinators, class_name: "DanvanthiriCore::PatientCoordinator"
  devise_for :doctors, class_name: "DanvanthiriCore::Doctor"
  devise_for :patients, class_name: "DanvanthiriCore::Patient"
end
