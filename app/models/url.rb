class Url < ActiveRecord::Base
  # non-database, set by controller to the actual URL (from Router)
  attr_accessor :full

  attr_accessible :long
  validates :long, presence: true

  after_create :compute_short_and_save!

  def ratio
    if self.full
      return Float(self.full.length) / self.long.length
    else
      return 0
    end
  end

  private
    def compute_short_and_save!
      # Short is only made up of 0-9a-z.
      # To ensure uniqueness, we build it from ID
      # A clever way of transforming an int into [0-9a-z] is to just use
      # its base36 representation, so we do just that.
      self.short = self.id.to_s(36)
      self.save!
      # if save fails, will raise exception and cancel the whole create
    end
end
