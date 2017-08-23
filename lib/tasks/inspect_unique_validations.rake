desc 'Finds unique validations in models that do not have DB indexes.'
task :inspect_unique_validations => :environment do
  inspector = UniqueValidationInspector::Inspector.new Rails.application
  inspector.load_everything!

  defined_unique_validations = inspector.defined_unique_validations

  puts
  puts "You have the following unique validations:"

  defined_unique_validations.each do |item|
    model = item[:model]
    puts
    puts "Model '#{model.name}':"
    item[:validators].each do |validation|
      scope = validation.options[:scope]
      attributes = validation.attributes
      index_exists = inspector.defined_unique_indexes(model.table_name, attributes, scope)
      puts "#{attributes} (scope '#{scope}'). Index exists: #{index_exists}"
    end
  end
  puts

end
