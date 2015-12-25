usage = "usage: #{$PROGRAM_NAME} <page name>"

if ARGV.length != 1
  $stderr.puts usage
  exit 1
end

page_name = ARGV[0]
puts "Page name: #{page_name}"
