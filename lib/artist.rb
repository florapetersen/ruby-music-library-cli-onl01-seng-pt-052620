

class Artist
  extend Concerns::Findable
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name) #creates a new instance of Artist by taking in an artist name
    artist = Artist.new(name) #calls initialize method with artist's name. this returns an instance of artist which is
    #set to a variable "artist"
    artist.save #calls save method on artist, which puts the current instance of the artist into the @@all array
    artist #returns the instance of artist
  end

  def songs
    @songs
  end

  def add_song(song)
    if song.artist == nil #
      song.artist = self
    end
    @songs << song unless @songs.include?(song)
  end

  def genres
    artist_genres = songs.collect {|song| song.genre}
    artist_genres.uniq
  end
end
