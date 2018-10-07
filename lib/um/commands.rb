module Commands
  LIBEXEC_FILENAME_FORMAT = 'um-%s.rb'.freeze

  ALIASES = {
    'l' => 'list',
    'r' => 'read',
    'e' => 'edit',
    's' => 'edit',     # legacy support
    'set' => 'edit',   # legacy support
    't' => 'topic',
    'c' => 'config',
    'h' => 'help'
  }.freeze

  # Executes the right Ruby file for the given command.
  def self.libexec(libexec_dir, cmd)
    file_path = file_path_for_command(libexec_dir, cmd)

    if file_path
      ARGV.shift
      run file_path
    else
      run file_path_for_command(libexec_dir, 'read')
    end
  end

  def self.file_path_for_command(libexec_dir, cmd)
    cmd = resolve_alias(cmd) || cmd
    filename = LIBEXEC_FILENAME_FORMAT % [cmd]
    path = "#{libexec_dir}/#{filename}"

    if File.exist?(path)
      path
    else
      nil
    end
  end

  class << self
    private

    def resolve_alias(cmd)
      ALIASES[cmd]
    end

    def run(file_path)
      exec(%{ruby "#{file_path}" #{ARGV.join(" ")}})
    end
  end
end
