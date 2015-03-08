# coding: utf-8
module BookDecorator
  def cover_image
    if book_cover?
      image_tag book_cover.url, alt: title, class: 'img-responsive'
    else
      image_tag 'no_image_book.gif', alt: title, class: 'img-responsive'
    end
  end
end
