class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    validate_format(record, attribute, value)
    validate_length(record, attribute, value)
  end


  private


  def validate_format record, attribute, value
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is an invlaid email")
    end
  end


  def validate_length record, attribute, value
    if value.nil?
      record.errors[attribute] << (options[:message] || "is required")
      return
    end

    if value.length > 80
      record.errors[attribute] << (options[:message] || "is allowed 80 characters maximum")
    end
  end
end
