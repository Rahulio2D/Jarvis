namespace :spec do
  desc "Run all RSpec tests"
  task all: :environment do
    system("bundle exec rspec")
  end

  desc "Run RSpec tests with coverage"
  task coverage: :environment do
    system("COVERAGE=true bundle exec rspec")
  end
end 