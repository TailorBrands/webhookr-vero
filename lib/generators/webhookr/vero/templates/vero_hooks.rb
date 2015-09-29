class VeroHooks

  # All 'on_' handlers are optional. Omit any you do not require.
  # Details on the payload structure: http://www.getvero.com/help/reporting/setting-up-veros-webhooks/
  #

  def on_sent(incoming)
    user = incoming.user
    puts("Email sent: (#{user})")
  end

  def on_delivered(incoming)
    user = incoming.user
    puts("Email deliverd: (#{user})")
  end

  def on_opened(incoming)
    user = incoming.user
    puts("Email opened: (#{user})")
  end

  def on_clicked(incoming)
    user = incoming.user
    puts("Email clicked: (#{user})")
  end

  def on_bounced(incoming)
    user = incoming.user
    puts("Email bounced: (#{user})")
  end

  def on_unsubscribed(incoming)
    user = incoming.user
    puts("User unsubscribed: (#{user})")
  end

  def on_user_updated(incoming)
    user = incoming.user
    puts("User updated: (#{user})")
  end
end
