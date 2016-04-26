module UserNotifier
  module Configuration
    VALID_CONFIG_KEYS    = [:system_email, :email_layout, :user_class_name, :from_email, :from_name, :use_xsmtp_api, :auto_deliver, :cc].freeze

    DEFAULT_SYSTEM_EMAIL      = nil
    DEFAULT_CC                = nil
    DEFAULT_EMAIL_LAYOUT      = 'email'
    DEFAULT_USER_CLASS_NAME   = 'User'
    DEFAULT_FROM_EMAIL        = 'no-reply@yourdomain'
    DEFAULT_FROM_NAME         = 'please configure a default from name'
    DEFAULT_USE_XSMTP_API     = false
    DEFAULT_AUTO_DELIVER      = true

    # Build accessor methods for every config options so we can do this, for example:
    #   Awesome.format = <img src="http://s2.wp.com/wp-includes/images/smilies/icon_mad.gif?m=1129645325g" alt=":x" class="wp-smiley"> ml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def configure
      yield self if block_given?
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset
      self.system_email       = DEFAULT_SYSTEM_EMAIL
      self.email_layout       = DEFAULT_EMAIL_LAYOUT
      self.user_class_name    = DEFAULT_USER_CLASS_NAME
      self.from_email         = DEFAULT_FROM_EMAIL
      self.cc                 = DEFAULT_CC
      self.from_name          = DEFAULT_FROM_NAME
      self.use_xsmtp_api      = DEFAULT_USE_XSMTP_API
      self.auto_deliver       = DEFAULT_AUTO_DELIVER
    end

  end # Configuration
end

