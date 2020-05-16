class ToDo < ApplicationRecord
    belongs_to :user
    validates :description, presence: true,
            length: {minimum: 5, maximum: 200}
end
