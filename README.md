## Oomba Coding Test

### Dependencies
This app was developed and tested with the following versions.

* Ruby 2.4.0
* Rails 5.0.2

There are no other dependencies other than the gems in the Gemfile.

### Installation

Here are the steps to get this project up and running for the first time locally.

````
git clone git@github.com:tconklin63/oomba-code-test.git
cd oomba-code-test
bundle install
rake db:create
rake db:migrate
````
Optionally you can also seed the database with some random test data.

````
rake db:seed
````
To run the unit tests execute the following.

````
bundle exec rspec
````
### Running the App
This app is configured to use the Puma web server locally when running in a development environment. Emails will be opened in the browser with the 'letter_opener' gem. To run the server, execute the following from the app root.

````
rails s
````
The app will then be availble in the browser at http://localhost:3000
### Additional Information
Since it was not a requirement, there is no user athentication. Anyone can create teams and invite users without any login required. Teams can be created in the app itself, but the only way to create users is by seeding the database, using the Rails console, or inviting users via email in the app.