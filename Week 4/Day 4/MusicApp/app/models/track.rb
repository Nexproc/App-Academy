class Track < ActiveRecord::Base
  belongs_to :album
  validates :name, :album_id, :bonus, presence: true
end
