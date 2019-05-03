class Task < ApplicationRecord
    validates :content, presence: { message: 'タスクが空です' }, length: { maximum:255 }
    #message: 'タスクは255文字以内にしてください' }
end
