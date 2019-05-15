class MusicLibraryController
  attr_accessor :path
  def initialize(path="./db/mp3s")
    @path=path
    @music_importer=MusicImporter.new(path)
    @music_importer.import
  end


  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = ""
    loop do
      input = gets.strip
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
      list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
      list_songs_by_genre
      when "play song"
        play_song
      else
        "Command not found."
      end
      break if input == 'exit'
    end



  end


  def list_songs

    index = 0

    sorted_songs=Song.all.sort{|prev_song,next_song| prev_song.name<=>next_song.name}

    sorted_songs.each do |song|

      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"

      index+=1

    end

  end


  def list_artists

    index = 0

    sorted_artists=Artist.all.sort{|prev_artist,next_artist| prev_artist.name<=>next_artist.name}

    sorted_artists.each do |artist|

      puts "#{index+1}. #{artist.name}"

      index+=1

    end

  end


  def list_genres

    index=0

    sorted_genres=Genre.all.sort{|prev_genre,next_genre| prev_genre.name<=>next_genre.name}

    sorted_genres.each do |genre|

      puts "#{index+1}. #{genre.name}"

      index+=1

    end

  end


  def list_songs_by_artist

    puts "Please enter the name of an artist:"

    artist_name = gets.strip

    artist_found=Artist.find_by_name(artist_name)

    if(!artist_found.nil?)

      index=0

      sorted_songs = artist_found.songs.sort{|prev_song,next_song| prev_song.name <=> next_song.name }


      sorted_songs.each do |song|

        puts "#{index+1}. #{song.name} - #{song.genre.name}"

        index+=1

      end

    end

  end


  def list_songs_by_genre

     puts "Please enter the name of a genre:"

     genre_name = gets.strip

     genre_found=Genre.find_by_name(genre_name)

     if(!genre_found.nil?)

       index=0

       sorted_genres = genre_found.songs.sort{|prev_genre,next_genre| prev_genre.name <=> next_genre.name }

       sorted_genres.each do |song|

         puts "#{index+1}. #{song.artist.name} - #{song.name}"

         index+=1

       end

     end

  end


  def play_song
    puts "Which song number would you like to play?"
    number_chosen = gets.strip.to_i
    real_index=number_chosen-1
    if (1...Song.all.length-1).include? real_index
      sorted_songs=Song.all.sort{|prev_song,next_song| prev_song.name <=> next_song.name}
      song_chosen=sorted_songs[number_chosen-1]
      puts "Playing #{song_chosen.name} by #{song_chosen.artist.name}"
    end
  end
end