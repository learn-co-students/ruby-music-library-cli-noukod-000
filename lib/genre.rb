class Genre


  extend Concerns::Findable


  @@all=[]


  attr_accessor :name

  attr_reader :songs


  def initialize(name)

    @name=name

    @songs=[]

  end


  def genre=(song)
    @songs << song
  end
  def artists

    songs_by_genre=@songs.select {|song| song.genre.name==@name}

    songs_by_genre.collect do |song|

      song.artist

    end.uniq

  end


  def self.all

    @@all

  end


  def save

    @@all << self

  end


  def self.destroy_all

    @@all=[]

  end


  def self.create(genre_name)

    genre = Genre.new(genre_name)

    @@all << genre

    genre

  end


end