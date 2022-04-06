# frozen_string_literal: true

module ChatroomsHelper
  def last_message
    messages.order(:created_at).last
  end
end
