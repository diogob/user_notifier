class UserNotifier::EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform model_name, notification_id
    resource = notification_model(model_name).find_by id: notification_id
    # We don't want to raise exceptions in case our notification does not exist in the database
    if resource
      mailer.notify(resource).deliver
    else
      raise "Notification #{notification_id} not found.. sending to retry queue"
    end
  end

  private
  def notification_model(model_name)
    @klass ||= Object.const_get(model_name)
  end

  def mailer
    UserNotifier::BaseMailer
  end
end
