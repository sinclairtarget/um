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

    IO.foreach(path) do |line|
      if line[/(\w+) = ([\w \/\(\)\.]+)/]
        config[$1] = $2
      elsif line.chomp.length > 0
        $stderr.puts "Unable to parse configuration file line: '#{line.chomp}'"
      end
    end

    config
  end
end
