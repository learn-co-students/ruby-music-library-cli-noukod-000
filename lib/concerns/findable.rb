module Concerns::Findable
  def find_by_name(name_music)
    all.detect{|ag| ag.name == name_music}
  end
  
  def find_or_create_by_name(name_of_music)
    find_by_name(name_of_music) || create(name_of_music)
  end
end