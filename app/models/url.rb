##
# Represents a full URL that was shortened.
# 
class Url < ActiveRecord::Base
  # non-database, set by controller to the actual URL (from Router)
  attr_accessor :full

  # only user-modifiable attribute is 'long'
  attr_accessible :long
  validates :long, presence: true

  after_create :compute_short_and_save!

  ##
  # The compression ratio, that is new URL length divided
  # by original url length.
  # Beware, this requires setting the new url on the object before.
  # This has to be done at controller level, as new url depends on routing
  # which should not be accessed from a model.
  def ratio
    if self.full
      return Float(self.full.length) / self.long.length
    else
      return 0
    end
  end

  private
    ##
    # Computes the short version of the URL and save it,
    # do not call directly, it is automatically invoked upon object creation in DB.
    # 
    # This method should only be called on an object that already have an ID.
    # Also, it should be part of the same transaction that creates the object
    # to maintain DB consistency
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
