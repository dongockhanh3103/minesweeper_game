module GameHelper
  def status_label(status)
    case status
    when Game.statuses[:playing]
      content_tag(:span, I18n.t('games.statuses.playing'), class: 'badge bg-warning')
    when Game.statuses[:lost]
      content_tag(:span, I18n.t('games.statuses.lost'), class: 'badge bg-danger')
    when Game.statuses[:won]
      content_tag(:span, I18n.t('games.statuses.won'), class: 'badge bg-success')
    when Game.statuses[:initial]
      content_tag(:span, I18n.t('games.statuses.initial'), class: 'badge bg-secondary')
    end
  end

  def datetime_formatted(datetime)
    datetime.strftime('%d/%m/%Y %H:%M')
  end
end
