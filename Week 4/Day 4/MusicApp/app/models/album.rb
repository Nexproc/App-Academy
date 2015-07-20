class Album < ActiveRecord::Base
  STYLES = ["LIVE", "STUDIO"]
  has_many :tracks, dependent: :destroy
  belongs_to :band
  validates :title, :band_id, :style, presence: true
  validate :is_valid_style

  def is_valid_style
    unless STYLES.include?(self.style.upcase) && !self.style.empty?
       errors[:style] << "Must be recorded live or in studio."
     end
  end
end
