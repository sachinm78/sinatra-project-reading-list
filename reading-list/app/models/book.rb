class Book < ActiveRecord::Base
    belongs_to :user
  
    validates :title, :author, presence: true
end