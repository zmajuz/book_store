module ResponseHelper
  def parsed_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def response_data
    parsed_response[:data]
  end
end
