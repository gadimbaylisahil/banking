require "bundler/setup"
require "banking"
require "active_record"
require "pry-byebug"
require 'database_cleaner'
def db_configuration
	db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
	YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["test"])

RSpec.configure do |config|
	config.example_status_persistence_file_path = ".rspec_status"
	config.disable_monkey_patching!
	config.expect_with :rspec do |c|
		c.syntax = :expect
	end
	
	config.before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end
	
	config.around(:each) do |example|
		DatabaseCleaner.cleaning do
			example.run
		end
	end
	
	config.after(:each) do
		DatabaseCleaner.clean
	end
	
	config.around do |example|
		ActiveRecord::Base.transaction do
			example.run
			raise ActiveRecord::Rollback
		end
	end
end