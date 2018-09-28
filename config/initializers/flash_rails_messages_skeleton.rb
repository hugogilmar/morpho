module FlashRailsMessages
  class Base
    def alert_element(type, message)
      content_tag :div, class: alert_classes(type) do
        message.html_safe
      end
    end

    def default_alert_class
      'alert'
    end

    def alert_type_classes
      {
        success: 'alert-success',
        notice: 'alert-info',
        alert: 'alert-warning',
        error: 'alert-error',
      }
    end
  end
end
