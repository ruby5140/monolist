class User < ApplicationRecord
  #バリデーション -検証
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  #暗号化
  has_secure_password
  
  has_many :ownerships
  has_many :items, through: :ownerships
  
  #Want した Item だけ」を user.want_items で取得
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end

end

