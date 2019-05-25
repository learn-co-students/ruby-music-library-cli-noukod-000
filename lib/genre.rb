class Genre
  extend Concerns::Findable # we aren't going to repeat the code of Song class
    attr_accessor :name
    attr_reader :songs # becuz of the weird setter on class song (no add_songs)
  def initialize(name)
    @name = name
    @songs = [] # Genres have many songs 
    #and are initialized with an empty list of songs.
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
  def self.create(name_of_genre) 
    genre = Genre.new(name_of_genre)
    genre.save
    genre
  end
  
  # Association with song: genre have many songs / song belong to one genre
  def songs
    @songs
  end
  
  #Genres have many artists through their songs.
  def artists
    songs.collect{|s| s.artist}.uniq
  end
  
  
end