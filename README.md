# User Notifier [ ![Codeship Status for diogob/user_notifier](https://codeship.io/projects/1221b8a0-e444-0131-ad0b-02cdfbaffe0d/status)](https://codeship.io/projects/25561) [![Code Climate](https://codeclimate.com/github/diogob/user_notifier.png)](https://codeclimate.com/github/diogob/user_notifier)

User Notifier creates a very simple pattern to solve event generated 
notifications for the users of a Rails application
It's an engine that will create Model and Mailer objects on the fly as well 
as a Sidekiq worker to send email in the background.
Although the gem was developed assuming that these notifications are all 
delivered by email, it would not be difficult to extend it for other kinds of message.

## Installation
Include in your Gemfile:
```ruby
gem 'user_notifier'
```
Then run:

    rails g user_notifier:install

This will create an initializer in ```config/initializers/user_notifier.rb```

This project rocks and uses MIT-LICENSE.
