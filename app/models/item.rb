class Item < ApplicationRecord
    belongs_to :todo
    validates :title, presence: true, length: { minimum: 120 }
end