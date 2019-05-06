class Genre 
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
   
   def self.create(genre)
     Genre.new(genre).tap {|genre| genre.save} 
    # @name = genre
    # @@all.push(genre)
    # genre
   end 
   
   def artists
     songs.map {|el| el.artist}.uniq
   end 
end 