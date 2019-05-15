class Artist
  extend Concerns::Findable
  @@all=[]
  attr_accessor :name,:genres,:artist
  attr_reader :songs
  def initialize(name)
    @name=name
    @songs=[]
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


  def self.create(artist_name)

    artist = Artist.new(artist_name)

    @@all << artist

    artist

  end


  def add_song(song)

      if !@songs.include?(song)

        @songs << song

      end

      #binding.pry

      song.artist ||= self

      return song

  end


  def genres

    artists_songs=@songs.select {|song| song.artist.name==@name}

    artists_songs.collect do |song|

      song.genre

    end.uniq

  end


end