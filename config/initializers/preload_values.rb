DetSker::Application.configure do
  values = YAML.load_file("#{Rails.root}/config/predefined_values.yml")
  config.possible_categories = values['categories']
  config.possible_locations = values['locations']
end
