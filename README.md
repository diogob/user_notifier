# User Notifier [ ![Codeship Status for diogob/user_notifier](https://codeship.io/projects/1221b8a0-e444-0131-ad0b-02cdfbaffe0d/status)](https://codeship.io/projects/25561) [![Code Climate](https://codeclimate.com/github/diogob/user_notifier.png)](https://codeclimate.com/github/diogob/user_notifier)

User Notifier creates a very simple pattern to store and manage event generated 
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

## Notification sources and recipient
This gem assumes that all notifications can be represented as a relation mapping a
source (some model tied to the event that triggered the notification) 
to a recipient (a user of your application).

## Generating a notification recipient
As we assume that all recipients are users in your system, we just need to tell 
the engine which model stores these users. This can be done in the initializer
generated during the installation. Assuming you have a model called User
the default initializer will work for you:
```ruby
UserNotifier.configure do |config|
  config.user_class_name  = 'User'
end
```

## Generating a notification source

Let's assume that our system have a model called ```Order```.
This model generates notifications for users in several different occasions.
But all these events share the same model as a common source for the notification, so we 
consider ```Order``` to be our notification source. Therefore we should create a database table
to store all these notifications. We use the ```notification``` generator:

    rails g user_notifier:notification order

This project rocks and uses MIT-LICENSE.
