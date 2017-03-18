module StaffHelper
  include HtmlBuilder

  def number_of_unprocessed_messages
    markup do |m|
      m.a({href: inbound_staff_messages_path, class:'unprocessedMessages'}) do
        m << I18n.t('staff.top.dashboard.unprocessed_messages')
        if (c = CustomerMessage.unprocessed.count) > 0
          anchor_text = "(#{c})"
        else
          anchor_text = ''
        end
        m.span(anchor_text, id: 'number-of-unprocessed-messages')
      end
    end
  end
end