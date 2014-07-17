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
Take a look in this initializer to tweak the default attributes of notifications.

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
    rake db:migrate

Now that this migration created a table to store our notifications from that source we can
add the code in the model that includes the **notify** methods:
```ruby
class Order < ActiveRecord::Base
  has_notifications
end
```
That's all, now we have the Order model as a notification source and events in this model
can send notifications to users in the User model. All this notifications can me accessed
in the notifications associations like in ```Order.first.notifications```

## Creating templates for the notifications
All notifications templates should be stored in ```user_notifier/mailer/``` in your
views directory. You should create at least two views for each notification you want to send,
one for the body of the email and another one for the subject.
Let's say we want to create a notification to users when orders are confirmed.
We can call this the order_confirmed notification and create two templates:

    user/notifier/mailer/order_confirmed.html.erb
    user/notifier/mailer/order_confirmed_subject.html.erb

Inside the templates we can use the ```@notification``` to access notification attributes.
The ```@notification.source``` or ```@notification.order``` will give access to the order 
model linked to the notification. The ```@notification.user``` will give access to the user model
(this association name can vary according to the configuration but user is the default).

## Sending notifications
Now to send an order_confirmed notification we simply call the method notify as in:
```ruby
user = User.first
order = Order.first
order.notify(:order_confirmed, user)
```

This project rocks and uses MIT-LICENSE.
