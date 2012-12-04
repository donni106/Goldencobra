unless ::Rails.root.to_s.include?("/test/dummy")
  all_files_exists = []
  Dir.foreach(File.join(Goldencobra::Engine.root,"db", "migrate")) do |f|
    file_to_search = f.split(".")[0].split("_")[1..-1].join("_")
    single_all_files_exists = []
    Dir.foreach(File.join(::Rails.root,"db", "migrate")) do |g|
      compare_with = g.split(".")[0].split("_")[1..-1].join("_")
      if compare_with == file_to_search
        single_all_files_exists << true
      else
        single_all_files_exists << false
      end
    end
    all_files_exists << single_all_files_exists.include?(true)
  end
  if all_files_exists.include?(false)
    raise "There are new migrations to install: rake goldencobra:install:migrations"
  end
end
