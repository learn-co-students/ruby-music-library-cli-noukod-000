class Artist
  extend Concerns::Findable # we aren't going to repeat the code of Song class
    #Artists have many genres through their songs. 
    # Genres have many artists through their songs.
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @songs = [] # association with songs -  Artist has many songs
  end
  
  @@all = [] # class will remember itsef (each new instance born)
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  ################extend the power of initialize
  def save # save the instance to all
    @@all << self
  end
  # custom constructor
  def self.create(name_of_artist) 
    artist = Artist.new(name_of_artist)
    artist.save
    artist
  end
  ############## Association with Song class (artist has many songs)
  def songs
    @songs
  end
  
  # to add_song - the artist has many songs and a song belongs to an artist
  def add_song(song)
    song.artist = self unless song.artist # to make the association valid in the song class
    @songs << song unless songs.include?(song) # to avoid repetition
  end
  
  # Genres have many artists through their songs.
  def genres
    songs.collect{|s| s.genre}.uniq
  end
end