require 'rake'
require 'spec/rake/spectask'

ROOT_DIR = File.dirname(__FILE__)
LOGS_DIR = File.join(ROOT_DIR, "log")
GEMS_DIR = "vendor"
SPEC_DIR = File.join(ROOT_DIR, "spec")

desc "Install the dependencies. You must have installed rake and rspec first."
task :bundle do
  Dir.chdir(ROOT_DIR) do
    puts "Checking installed gems...\t\t"
    system "bundle check"
    unless $?.success?
      puts "Installing required gems in #{GEMS_DIR.inspect}"
      system "bundle install #{GEMS_DIR}"
    end
  end
end

desc "Launch all the tests"
Spec::Rake::SpecTask.new('test') do |t|
  Rake::Task[:bundle].execute
  Dir.chdir(ROOT_DIR) do |dir|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = [
      "--require", "spec/spec_helper.rb",
      "--format", "html:reports/#{Time.now.to_i}.html",
      "--format", "html"
    ]
  end
  t.fail_on_error = false
end

task :default => :test
