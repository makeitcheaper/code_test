module WebMockHelpers
  def assert_requested_with_values method, url, values
    assert_requested(method, url, times: 1) do |req|
      params_str = URI.decode req.as_json["uri"]["query"]
      values.all? { |value| params_str =~ /#{value}/ }
    end
  end
end
