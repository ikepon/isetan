ActiveAdmin.register Book do
  permit_params :title, :asin, :wanted, :read, :rental, :book_cover

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Book' do
      f.input :title
      f.input :asin
      f.input :wanted
      f.input :read
      f.input :rental
      f.input :book_cover, as: :file
    end
    f.actions
  end

end
