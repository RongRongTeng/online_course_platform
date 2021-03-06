# frozen_string_literal: true

module ApplicationHelper
  def day_inspect(number)
    number.day.inspect
  end

  def true_false_label(bool)
    if bool
      content_tag(:span, 'true', class: 'badge bg-success')
    else
      content_tag(:span, 'false', class: 'badge bg-danger')
    end
  end
end
