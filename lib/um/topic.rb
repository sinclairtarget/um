require 'etc'
require 'fileutils'

module Topic
  def self.current
    topic = "shell"

    file_path = topic_file_path
    topic = read_topic(file_path) if File.exists? file_path

    topic
  end

  def self.set(topic)
    write_topic(topic_file_path, topic) unless topic.empty?
  end

  def self.clear
    File.delete topic_file_path
  end

  private 
  def self.topic_file_path
    tmp_dir_path = "/var/tmp/um/" + Etc.getlogin
    FileUtils.mkdir_p tmp_dir_path

    tmp_dir_path + "/current.topic"
  end

  def self.read_topic(path)
    line = File.readlines(path).first
    if line
      line.chomp
    else
      raise RuntimeError, "Empty or corrupt .topic file."
    end
  end

  def self.write_topic(path, topic)
    File.write(path, topic)
  end
end
