class Message < ActiveRecord::Base
  validates :content, presence: { allow_nil: true }
end
