class ApplicationController < ActionController::Base
    add_flash_types :success, :info, :warning, :danger
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

  def record_not_found
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

end
