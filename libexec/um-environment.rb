require_relative '../lib/um.rb'

set_from_config_file = {}
config_file_path = File.expand_path(Config::CONFIG_REL_PATH)

config = Config.source(set_from_config_file: set_from_config_file)
config.each do |key, value|
  line = "#{key} = #{value}"

  if set_from_config_file.has_key? key
    line << "\t(Set in #{config_file_path})"
  end

  puts line
end
