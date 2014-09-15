class ImageUploader < CarrierWave::Uploader::Base
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_limit => [50, 50]
  end

  # jpg,jpeg,gif,pngのみOKにする
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
