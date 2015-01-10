ActiveAdmin.register Book do
  permit_params :title, :asin, :wanted, :read, :rental
end
