class ToDo < ApplicationRecord
    validates :description, presence: true,
            length: {minimum: 5, maximum: 200}
    after_initialize :init # set initial values
    def init
        self.completed ||= false # set .completed to false if it is currently null
    end
end
