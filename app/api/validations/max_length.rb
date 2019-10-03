class MaxLength < Grape::Validations::Base
  def validate_param!(attr_name, params)
    param_value = params[attr_name]

    if param_value.nil?
      return
    end

    unless param_value.length <= @option
      raise Grape::Exceptions::Validation,
            params: [@scope.full_name(attr_name)],
            message: "must be at most #{@option} characters long"
    end
  end
end
