json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :cat, :dur, :name
  json.url exercise_url(exercise, format: :json)
end
