class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre

  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def notes=(notes)
    notes.each do |note|
      if n = Note.all.find { |n| n.content == note }
        self.notes << n
      else
        n = Note.create(content:note)
        self.notes << n
      end
    end
  end

end
