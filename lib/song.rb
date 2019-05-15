class Song


   extend Concerns::Findable


  @@all=[]


  attr_accessor :name

  attr_reader :artist,:genre


  def initialize(name,artist=nil,genre=nil)

    @name=name

    self.artist=artist

    self.genre=genre

  end


  def self.all

    @@all

  end


  def genre=(genre)

    if genre!=nil and !genre.songs.include?(self)

      genre.songs << self

    end

    @genre=genre

  end


  def artist=(artist)
     if artist!=nil && !artist.songs.include?(self)
       artist.add_song(self)
     end
     @artist=artist
  end


  def save

    @@all << self

  end


  def self.destroy_all

    @@all=[]

  end


  def self.find_by_name(name)

     @@all.select{|song| song.name==name}[0]

  end


  def self.find_or_create_by_name(name)

    found = Song.find_by_name(name)

    if(found.nil?)

      Song.create(name)

    else

      found

    end

  end


  def self.create(song_name)

    song = Song.new(song_name)

    @@all << song

    song

  end


  def self.new_from_filename(file_name)


    song_infos=file_name.split(" - ")
    song_name=song_infos[1]

    artist_name=song_infos[0]

    genre_name=song_infos[2].gsub(/.mp3/,'')
    artist = Artist.find_or_create_by_name(artist_name)

    genre = Genre.find_or_create_by_name(genre_name)

    song = Song.new(song_name,artist,genre)

  end


  def self.create_from_filename(file_name)
    song = Song.new_from_filename(file_name)
    song.save
  end


end