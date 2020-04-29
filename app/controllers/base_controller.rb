# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate_user!

  private

  def set_flash_message(text = 'Process Completely', type = :notice)
    flash[type] = text
  end
end
