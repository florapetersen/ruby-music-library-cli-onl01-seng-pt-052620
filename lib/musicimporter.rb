require 'pry'

class MusicLibraryController
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
    #user_input = gets until user_input == "exit"
      input = gets.strip

  end

  def list_songs
    songs_by_name = Song.all.uniq.sort_by {|song| song.name}
    songs_by_name.each.with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    alpha_artists = Artist.all.uniq.sort_by {|artist| artist.name}
    alpha_artists.each.with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    alpha_genres = Genre.all.uniq.sort_by {|genre| genre.name}
    alpha_genres.each.with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets
    if artist = Artist.find_by_name(user_input)
      artists_songs = artist.songs.uniq.sort_by {|song| song.name}
      artists_songs.each.with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets
    if genre = Genre.find_by_name(user_input)
      genre_songs = genre.songs.uniq.sort_by {|song| song.name}
      genre_songs.each.with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  #def play_song
    #song_list = list_songs
    #puts "Which song number would you like to play?"
    #puts "#{song_list}"
    #user_input = gets.chomp.to_i
    #if user_input >= 1 && user_input <= Song.all.uniq.length
      #current_song = Song.all.uniq[user_input]
      #puts "Playing #{current_song.name} by #{current_song.artist.name}" if current_song
    #end
  #end

  def play_song
    puts "Which song number would you like to play?"

    input = gets.strip.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.uniq.sort{ |a, b| a.name <=> b.name }[input - 1]
    end

    puts "Playing #{song.name} by #{song.artist.name}" if song
  end


end

class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path
  end

  def files #takes the filenames of the directory and returns an array of the filenames!
    mp3s = Dir.children(self.path)
  end

  def import #runs files method, which returns an array of filenames, then iterates through that array
    #and on each file, runs Song.create_from_filename
    files.each {|file| Song.create_from_filename(file)}
  end
end
