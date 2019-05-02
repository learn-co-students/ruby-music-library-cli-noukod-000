class MusicLibraryController
  attr_accessor :path
  @@all = []

  def initialize(path)
    @path << self
  end
end
