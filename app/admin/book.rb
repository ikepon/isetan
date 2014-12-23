ActiveAdmin.register Book do
  permit_params :title, :isbn, :wanted, :read, :rental
end
