desc 'Finds unique validations in models that do not have DB indexes.'
task :inspect_unique_validations => :environment do
  inspector = UniqueValidationInspector::Inspector.new Rails.application

  defined_unique_validations = inspector.defined_unique_validations

  puts "You have the following unique validations:"

  defined_unique_validations.each do |item|
      puts "Model '#{item[0]}':"
      item[1].each do |validation|
        puts "#{validation.attributes} (scope '#{validation.options[:scope]}')"
      end
  end

end
