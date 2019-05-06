module Concerns::Findable

# Allow to find an instance of the class by name.
  def find_by_name(f_name)
     all.detect do |song_dectect|
       song_dectect.name == f_name
     end
  end

# Allow to find an instance of the class by name and
# to create a new instance if a match is not found.
  def find_or_create_by_name(name) #
      self.find_by_name(name) || self.create(name)
  end

end