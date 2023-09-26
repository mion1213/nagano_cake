class Item < ApplicationRecord
  has_one_attached :image
  
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  
  def with_tax_price
    (price*1.1).floor
  end
  
  def status
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
  # Itemモデル内のget_imageメソッドを修正
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: "#{width}x#{height}!").processed
  end

end
