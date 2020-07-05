require 'pry'
class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil) #takes in a song name and sets song name to an instance variable of same name. optional second argument
    #is an artist object to be assigned to song's artist property (song belongs to artist)
    @name = name
    self.artist = artist if artist != nil #if the artist plugged in is NOT nil, this sets the artist argument
    #to be the artist of self (the current instance of song)
    self.genre = genre if genre != nil
  end

  def self.all #returns array of all instances of Song
    @@all
  end

  def self.destroy_all #clears array of all instances of Song
    @@all.clear
  end

  def save #saves the current instane of Song (self) to the @@all array
    @@all << self
  end

  def self.create(name) #method for creating new instance of Song; takes in a song name
    song = Song.new(name) #takes song name and calls initialize method. this returns an instance variable for the song
    #which is set to a variable song
    song.save #the method save is called on the song variable, so the instance of the song is saved to the @@all array
    song #returns the instance of the song
  end

  def artist=(artist) #takes in artist as argument
    @artist = artist #sets artist to instance variable
    self.artist.add_song(self) #calls the add_song method from Artist class on self (current instance of song)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(filename)
    artist_name = filename.split(" - ")[0]
    song_name = filename.split(" - ")[1]
    genre_name = filename.split(" - ")[2].chomp(".mp3")
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end

  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
  end
end
