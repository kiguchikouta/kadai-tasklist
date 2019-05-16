class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  
  # 後に使われるわけではなく、インスタンスをsaveする前に自分自身をdowncaseすることを命令しているロジック
  before_save { self.email.downcase! }
  
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } 
                    
  # Micropostモデルを作成するのと同時にこっちのUserモデルにhas_manyを加える必要あり
  has_many :tasks

end
