class UserNotifier::Base < ActiveRecord::Base
  self.abstract_class = true
  belongs_to UserNotifier.user_class_name

  def self.notify_once(template_name, user, filter, params = {})
    notify(template_name, user, params) if is_unique?(template_name, filter)
  end

  def self.notify(template_name, user, params = {})
    create!({
      template_name: template_name,
      locale: I18n.locale,
      from_email: UserNotifier.from_email,
      from_name: UserNotifier.from_name
    }.merge(params)).tap{|n| n.deliver }
  end

  def deliver
    deliver! unless self.sent_at.present?
  end

  def deliver!
    UserNotifier::EmailWorker.perform_async(self.class.name.to_s, self.id)
    self.update_attributes sent_at: Time.now()
  end

  private
  def self.is_unique?(template_name, filter)
    filter.nil? || self.where(filter.merge(template_name: template_name)).empty?
  end
end

