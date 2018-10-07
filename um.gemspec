require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'um'
  spec.version = File.read('version.txt').chomp
  spec.summary = 'Um man tool'
  spec.description = 'Command-line utility for creating and maintaining personal man pages'
  spec.authors = ['Sinclair Target']
  spec.email = 'sinclairtarget@gmail.com'
  spec.homepage = 'https://github.com/sinclairtarget/um'
  spec.licenses = ['MIT']
  spec.executables = ['um']

  spec.files = FileList[
    'lib/**/*.rb',
    'libexec/**/*.rb',
    'bin/um',
    'version.txt',
    'templates/**/*'
  ]

  spec.add_runtime_dependency 'kramdown', ['~> 1.17']
end
