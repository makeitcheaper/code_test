# frozen_string_literal: true

module CallbackHelper
  def error_message(code)
    case code
    when 400
      'Internal app error, try again later.'
    when 401
      'Unauthorised access_token'
    when 500
      "Can't contact Queue Server. Try again later."
    else
      'Internal app error, try again later.'
    end
  end
end
