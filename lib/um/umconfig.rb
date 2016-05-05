require 'etc'
require 'fileutils'

module UmConfig
  CONFIG_DIR_REL_PATH = "~/.um".freeze
  CONFIG_FILE_REL_PATH = "~/.um/umconfig".freeze

  DEFAULT_CONFIG = {
    pager: ENV['PAGER'] || "less",
    editor: ENV['EDITOR'] || "vi",
    pages_directory: File.expand_path("~/.um/pages"),
    default_topic: "shell"
  }.freeze

  # Sources the config file, returning the environment as a hash.
  def self.source
    config = {}

    if File.exists? config_path
      parsed_config = parse_config(config_path)
      config = DEFAULT_CONFIG.merge(parsed_config)
    else
      config = DEFAULT_CONFIG
    end

    write_pages_directory(config[:pages_directory])
    config
  end

  # Returns the keys in a configuration hash with values that aren't defaults.
  def self.non_default_keys(config)
    keys = []
    config.each do |key, value|
      keys << key if value != DEFAULT_CONFIG[key]
    end

    keys
  end

  def self.config_path
    config_path = File.expand_path(CONFIG_FILE_REL_PATH)
  end

  private
  def self.parse_config(path)
    config = {}

    parse_error_occurred = false
    File.foreach(path) do |line|
      if line[/(\w+) = ([\w \/\(\)\.]+)/]
        config[$1.downcase.to_sym] = $2
      elsif line.chomp.length > 0
        $stderr.puts "Unable to parse configuration file line #{$.}: " + 
          "'#{line.chomp}', skipping"
        parse_error_occurred = true
      end
    end

    $stderr.puts "Your configuration file is #{path}" if parse_error_occurred
    config
  end

  def self.write_pages_directory(pages_directory_path)
    tmp_dir_path = "/var/tmp/um/" + Etc.getlogin
    FileUtils.mkdir_p tmp_dir_path

    tmp_file_path = tmp_dir_path + "/current.pagedir"
    unless File.exists?(tmp_file_path)
      File.write(tmp_file_path, pages_directory_path)
    end
  end
end
