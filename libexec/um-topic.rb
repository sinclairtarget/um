require_relative '../lib/um.rb'

topic = ARGV.first

if topic.to_s.empty?
  puts Topic.current
else
  Topic.set topic
end
