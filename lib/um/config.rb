module Config
  def self.source
    config = {
      "pager" => ENV['PAGER'] || "less",
      "editor" => ENV['EDITOR'] || "vi",
      "pages_directory" => File.expand_path("~/.um/pages")
    }

    path = File.expand_path("~/.um/umconfig")
    config.merge! parse_config(path) if File.exists? path

    config
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
