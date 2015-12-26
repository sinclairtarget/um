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
      "um-#{cmd}.rb"
    else
      nil
    end
  end
end
