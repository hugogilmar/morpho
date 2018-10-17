module Morpho
  class ApplicationMailer < ActionMailer::Base
    layout 'mailer'

    before_action :attach_logo!

    protected

    def attach_logo!
      attachments.inline['logo.png'] = File.read(
        Rails.root.join('public', 'images', 'mailer-logo.png')
      )
    rescue StandardError
      # do nothing
    end
  end
end
