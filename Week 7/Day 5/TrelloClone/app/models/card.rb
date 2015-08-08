class Card < ActiveRecord::Base
  has_many :todo_items
  belongs_to :list
end
