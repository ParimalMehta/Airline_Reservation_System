json.extract! feedback, :id, :feedback_response, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
