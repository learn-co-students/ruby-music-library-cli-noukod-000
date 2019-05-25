class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path
  end
  
  def files
    # A Dir is a class to represent a directory stream that gives filenames in the directory in the operating system. Dir class also holds directory related operations, such as wild card filename matching, changing current working directory, etc. as class methods.
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end
  
  # direct communication
  def import
    files.each{ |f| Song.create_from_filename(f) }
  end
end