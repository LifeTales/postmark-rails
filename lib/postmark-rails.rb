require 'action_mailer'
require 'postmark'
require 'postmark-rails/delivery_method'

module PostmarkRails
  extend self

  def auto_detect_and_install
    if ActionMailer::Base.respond_to?(:add_delivery_method)
      install_in_rails
    else
      install_in_legacy_rails
    end
  end

  def install_in_legacy_rails
    ActionMailer::Base.send(:include, PostmarkRails::DeliveryMethod)
  end

  def install_in_rails
    ActionMailer::Base.add_delivery_method :postmark, Mail::Postmark, :api_key => nil
  end
end

PostmarkRails.auto_detect_and_install
