ActiveAdmin.register Collection do
  permit_params :status, :rented_at, :returned_at, :user_id, :book_id
end
