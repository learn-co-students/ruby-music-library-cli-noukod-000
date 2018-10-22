class Genre
attr_accessor :name, :songs
extend Concerns::Findable
@@all = []
  def initialize name
    @name = name
    @songs = []
  end

def self.all
  @@all
end

def self.destroy_all
  all.clear
end

def save
  Genre.all << self
end

def self.create(name)
  new(name).tap {|genre| genre.save}
end

def artists
    songs.collect {|song| song.artist}.uniq
  end
end
