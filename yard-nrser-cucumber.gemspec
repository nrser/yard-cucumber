lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "yard/nrser/cucumber/version"

# module CucumberInTheYARD
#   def self.show_version_changes(version)
#     date = ""
#     changes = []
#     grab_changes = false

#     File.open("#{File.dirname(__FILE__)}/History.txt",'r') do |file|
#       while (line = file.gets) do

#         if line =~ /^===\s*#{version.gsub('.','\.')}\s*\/\s*(.+)\s*$/
#           grab_changes = true
#           date = $1.strip
#         elsif line =~ /^===\s*.+$/
#           grab_changes = false
#         elsif grab_changes
#           changes = changes << line
#         end

#       end
#     end

#     { :date => date, :changes => changes }
#   end
# end

Gem::Specification.new do |spec|
  spec.name        = ::YARD::NRSER::Cucumber::NAME
  spec.version     = ::YARD::NRSER::Cucumber::VERSION
  spec.authors     = ["Neil Souza", "Franklin Webber"]
  spec.description = %{
    This is my fork of https://github.com/burtlo/yard-cucumber with some changes that I would
    like to consider improvements.
    
    YARD-Cucumber is a YARD extension that processes Cucumber Features, Scenarios, Steps,
    Step Definitions, Transforms, and Tags and provides a documentation interface that allows you
    easily view and investigate the test suite.  This tools hopes to bridge the gap of being able
    to provide your feature descriptions to your Product Owners and Stakeholders.  }
  spec.summary     = "Cucumber Features in YARD"
  spec.email       = 'neil@neilsouza.com'
  spec.homepage    = "http://github.com/nrser/yard-nrser-cucumber"
  spec.license     = 'MIT'

  spec.platform    = Gem::Platform::RUBY

#   changes = CucumberInTheYARD.show_version_changes(::CucumberInTheYARD::VERSION)

#   s.post_install_message = %{
# (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

#   Thank you for installing yard-cucumber #{::CucumberInTheYARD::VERSION} / #{changes[:date]}.

#   Changes:
#   #{changes[:changes].collect{|change| "  #{change}"}.join("")}
# (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

# }

  spec.add_development_dependency 'rake', '~> 10'

  spec.add_dependency 'gherkin', '>= 4.0', '< 6.0'
  spec.add_dependency 'cucumber', '>= 2.0', '< 4.0'
  spec.add_dependency 'yard', '~> 0.8', '>= 0.8.1'
  
  # Don't think we need this guy..?
  # spec.rubygems_version   = "1.3.7"
  spec.files            = `git ls-files`.split("\n")
  spec.extra_rdoc_files = ["README.md", "History.txt"]
  spec.rdoc_options     = ["--charset=UTF-8"]
  spec.require_path     = "lib"
end
