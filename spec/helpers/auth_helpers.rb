module AuthHelpers
  def add_token_to_request(token)
    request.headers.merge!({'X-AUTH-TOKEN' => token})
  end
end