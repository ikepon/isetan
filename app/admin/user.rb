ActiveAdmin.register User do
  permit_params :name, :email, :password, :profile, :image, :remember_token, :current_sign_in_at, :role

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'User' do
      f.input :name
      f.input :email
      f.input :password
      f.input :profile
      f.input :image, as: :file
      f.input :role
    end
    f.actions
  end
end
