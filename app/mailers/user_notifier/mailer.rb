class UserNotifier::Mailer < ActionMailer::Base
  layout UserNotifier.email_layout

  def notify(notification)
    @notification = notification
    I18n.with_locale @notification.locale do
      subject = render_to_string(template: "user_notifier/mailer/#{@notification.template_name}_subject")
      mail({
        from: address_format(UserNotifier.system_email, @notification.from_name),
        reply_to: address_format(@notification.from_email, @notification.from_name),
        to: @notification.user.email,
        subject: subject,
        template_name: @notification.template_name
      })
    end
  end

  private
  def address_format email, name
    address = Mail::Address.new email
    address.display_name = name
    address.format
  end
end
