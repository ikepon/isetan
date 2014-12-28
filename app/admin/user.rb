ActiveAdmin.register User do
  permit_params :name, :email, :password_digest, :profile, :image, :remember_token, :current_sign_in_at, :role
end
