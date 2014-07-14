# PronosticosDashboard

Try it out:

  bundle install
  bundle exec rake db:setup
  bundle exec shotgun

In order to test the data importer you need a .env file with settings
like:

  GOOGLE_DRIVE_EMAIL=some_email
  GOOGLE_DRIVE_PASSWORD=some_password
  GOOGLE_SPREADSHEET=Pronosticos Sales

The example spreadsheet is something like:
https://docs.google.com/spreadsheets/d/1njwIHZfk9zNNoSUr8CN9MfekiTqvdTVlz_geeL959Z4/edit?usp=sharing

The just run:

  bundle exec rake import
