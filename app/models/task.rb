class Task < ApplicationRecord
    belongs_to :user
    
    validates :content, presence: { message: 'が空です' }, length: { maximum:255 , message: 'は255文字以内にしてください' }
    validates :status, presence: { message: 'が空です' }, length: { maximum:10 , message: 'は10文字以内にしてください' }

    # これは一切いらなかった。これを入れるとタスク登録ができなくなる
    # というよりそもそもbelongs_to :userだけで十分
    # validates :user, presence: true, length: { maximum:20 }
end
