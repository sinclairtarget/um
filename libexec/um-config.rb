require_relative '../lib/um.rb'

Options.parse! do |available_opts|
  available_opts.banner = 'usage: um config [config key]'

  available_opts.on('-h', '--help', 'Print this help message.') do
    puts available_opts
    exit 0
  end
end

config = UmConfig.source

# If a valid key has been specified, print the value
config_key = ARGV.first
if config_key and config.has_key?(config_key.to_sym)
  puts config[config_key.to_sym]
  exit 0
end

# Otherwise print all key/value pairs in the configuration
non_default_keys = UmConfig.non_default_keys(config)
config_file_path = UmConfig.config_path

unless non_default_keys.empty?
  puts "Options prefixed by '*' are set in #{config_file_path}."
  puts '=' * 80
end

config.each do |key, value|
  option = "#{key} = #{value}"

  if non_default_keys.include?(key)
    puts '* ' + option
  else
    puts '  ' + option
  end
end
