desc "Default: run unit tests"
task :default do
  exec "echo \"Dir.glob('./test/**/*_test.rb').each { |file| require file}\" | ruby -Itest -Ilib"
end