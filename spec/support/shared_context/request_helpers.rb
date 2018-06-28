def json(options = {})
  @json ||= JSON.parse(response.body, options)
end

def post_json(path, data)
  headers = { 'Content-Type' => 'application/json' }
  post("/api/#{path}", params: data.to_json, headers: headers)
end

def json_response(options = {})
  json(options.merge(symbolize_names: true))
end
