class Song
  # a song belong to one artist (:artist as an attr)
  # a song belong to one genre (:genre as an attr)
  attr_accessor :name
  attr_reader :artist,:genre
  def initialize(name,artist=nil, genre = nil) # a song belong to an artist (:artist as an attr)
    @name = name
    self.artist = artist if artist # a song belong to an artist (:artist as an attr)
    self.genre = genre if genre # a song belong to one genre (:genre as an attr)
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
  def self.create(name_of_song) 
    song = Song.new(name_of_song)
    song.save
    song
  end
  # songs belong to an artist - a setter
  # create the  add_song on the artist class
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  # songs belong to a genre
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self) # could've used the artist.add_song way 
  end
  
  # find a Song
  # all return the Array
  def self.find_by_name(name_music)
    all.detect{|s| s.name == name_music}
  end
  # find_or_create_by_name
  def self.find_or_create_by_name(name_of_music)
    find_by_name(name_of_music) || create(name_of_music)
  end
  
  # new_from_filename
  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")
    # straight communication
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    Song.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save } # oneliner
    #to avoid sNDWICH CODE
  end
  
end