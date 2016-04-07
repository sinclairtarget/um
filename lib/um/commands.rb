module Commands
  ALIASES = {
    "e" => "environment",
    "l" => "list",
    "r" => "read",
    "s" => "set",
    "t" => "topic",
    "h" => "help"
  }

  def self.resolve_alias(cmd)
    ALIASES[cmd]
  end

  def self.libexec(cmd)
    cmd = resolve_alias(cmd) || cmd 
    file_path = file_path_for_command(cmd)

    if file_path
      ARGV.shift
      run file_path
    else
      run file_path_for_command("read")
    end
  end

  private
  def self.file_path_for_command(cmd)
    dir = File.expand_path("../../libexec", File.dirname(__FILE__))
    path = "#{dir}/um-#{cmd}.rb"
    if File.exist?(path)
      path
    else
      nil
    end
  end

  def self.run(file_path)
    exec(%{ruby "#{file_path}" #{ARGV.join(" ")}})
  end
end
