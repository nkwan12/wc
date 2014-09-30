json.extract! @workout, :id, :name, :num_exercises

json.exercises do
  json.array! @workout.exercises, :id, :name, :cat, :dur
end
    
