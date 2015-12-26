module Commands
  ALIASES = {
    "e" => "environment",
    "l" => "list",
    "r" => "read",
    "s" => "set",
    "t" => "topic",
    "h" => "help"
  }

  def self.alias(cmd)
    ALIASES[cmd]
  end

  def self.libexec(cmd)
    if ALIASES.values.include? cmd
      dir = File.expand_path("../../libexec", File.dirname(__FILE__))
      "#{dir}/um-#{cmd}.rb"
    else
      nil
    end
  end
end
