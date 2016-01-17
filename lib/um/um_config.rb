module UmConfig
  CONFIG_DIR_REL_PATH = "~/.um"
  CONFIG_FILE_REL_PATH = "~/.um/umconfig"

  def self.source(set_from_config_file: {})
    default_config = {
      "pager" => ENV['PAGER'] || "less",
      "editor" => ENV['EDITOR'] || "vi",
      "pages_directory" => File.expand_path("~/.um/pages"),
      "default_topic" => "shell"
    }

    config_path = File.expand_path(CONFIG_FILE_REL_PATH)
    if File.exists? config_path
      set_from_config_file.merge! parse_config(config_path) 
    end

    default_config.merge set_from_config_file
  end

  private
  def self.parse_config(path)
    config = {}

    parse_error_occurred = false
    File.foreach(path) do |line|
      if line[/(\w+) = ([\w \/\(\)\.]+)/]
        config[$1.downcase] = $2
      elsif line.chomp.length > 0
        $stderr.puts "Unable to parse configuration file line #{$.}: " + 
          "'#{line.chomp}', skipping"
        parse_error_occurred = true
      end
    end

    $stderr.puts "Your configuration file is #{path}" if parse_error_occurred
    config
  end
end
