# Banking App
*Small Plain Ruby application to make transfers between Bank accounts. Fully tested with Rspec and Data Persistance achieved with Postgresql.*

### Prerequisites. Make sure you have these installed on your local machine:

1. Ruby(2.4.0)
2. Postgres(9.6+)
3. Bundler(1.16)


Followings are used as dependencies of the application.
1. activerecord: To get access to query methods and validations.
2. pg: Connecting to a Postgresql database
3. pry (~> 0.11.3): Alternative to irb console
4. pry-byebug: Better Debugging with Pry
5. rspec (~> 3.7): Testing framework to write speclike tests.
6. standalone_migrations: Enables rake tasks to manage the database and its migrations.

### Instructions

##### Set up the Project
1. Clone the repository from github.
2. cd to project directory and run bundle install

# Set up the database
1. Run `bundle exec rake:db:create`
2. Run `bundle exec rake db:migrate`

##### Prepare test database.
1. Run `bundle exec rake db:test:prepare`

####Run the application and see the output for example case
`bundle exec ruby lib/show_me_the_money.rb`

#### Tests
To run all the tests `cd` to main directory and run
`bundle exec rspec`