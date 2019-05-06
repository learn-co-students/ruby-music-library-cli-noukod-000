class Song 
  attr_accessor :name
  attr_reader :artist,:genre
 
  
  @@all = []
  
  #instance methods
  def initialize(name,artist ="",genre ="")
    @name = name
    artist != "" ? self.artist = artist : self.artist = Artist.new(artist)
    genre != "" ? self.genre = genre : self.genre = Genre.new(genre)
    @@all.push(self)
   
  end 
   
   def artist=(artist)
    @artist = artist
    artist.add_song(self)
   end 
   
   def genre=(genre)
     @genre = genre
     genre.songs.push(self) unless genre.songs.include?(self)
   end 
   
    def save
      @@all.push(self)
   end 
   
    #class Methods
   def self.all
     @@all
   end 
   
   def self.destroy_all
     all.clear
   end
   
   def self.create(name)
    Song.new(name).tap {|song| song.save} 
   end 
     
  def self.find_by_name(name)
     all.detect {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    if find_by_name(name)
      find_by_name(name)
    else 
      create(name)
    end 
  end 
  
  def self.new_from_filename(filename)
     artist_name, song_name, genre = filename.gsub(".mp3","").split(" - ")
     Song.new(song_name,Artist.find_or_create_by_name(artist_name),Genre.find_or_create_by_name(genre))
  end 
  
  def self.create_from_filename(filename)
    new_from_filename(filename).tap {|song| song.save}
  end 
end 