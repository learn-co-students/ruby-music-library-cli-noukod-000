class MusicLibraryController
  attr_accessor :path
  @@all = []

  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
  end
  
  def call 
  end
end
