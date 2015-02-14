# coding: utf-8
module UserDecorator
  def profile_image
    if image?
      image_tag image.thumb.url, alt: name, title: name
    else
      image_tag 'noimage.jpg', size: '70x70', alt: name, title: name
    end
  end
end
