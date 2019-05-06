class Artist 
  extend Concerns::Findable
  attr_accessor :name 
  attr_reader :songs 
  @@all= []
  
  def initialize(name)
    @name = name 
    @@all << self
    @songs = []
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all
     all.clear
   end
   
   def save
      @@all.push(self)
   end 
   
   def self.create(artist)
     Artist.new(artist).tap {|artist| artist.save} 
    # @name = artist
    # @@all.push(artist)
    # artist
   end 
   
   def find_song(song)
     songs.find{|el| el.name == song}
   end
   
  
  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
   end 
  
  
  def genres 
    songs.map {|el| el.genre}.uniq 
  end 
 
end 