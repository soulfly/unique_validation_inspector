desc 'Finds unique validations in models that do not have DB indexes.'
task :inspect_unique_validations => :environment do
  inspector = UniqueValidationInspector::Inspector.new Rails.application
  inspector.load_everything!

  defined_unique_validations = inspector.defined_unique_validations

  puts

  if defined_unique_validations.any?
    puts "You have the following unique validations:"

    have_at_least_one_issue = false

    defined_unique_validations.each do |item|
      model = item[:model]
      puts
      puts "Model '#{model.name}':"
      item[:validators].each do |validation|
        scope = validation.options[:scope]
        attributes = validation.attributes
        index_exists = inspector.defined_unique_indexes(model.table_name, attributes, scope)
        have_at_least_one_issue = true unless index_exists
        message = "#{attributes}"
        message += " (scope '#{scope}')" if scope
        message += ". Index exists: #{index_exists}."
        puts message
      end
    end

    puts

    if have_at_least_one_issue
      puts "Consider use one of the following solutions to resolve above issues:\n"
      puts "#1. Add proper DB index.\n"
      puts "#2. Move unique validation to DB level.\n"
      puts "More info in the article https://medium.com/@igorkhomenko/rails-make-sure-you-have-proper-db-indexes-for-your-models-unique-validations-ffd0364df26f"
    else
      puts "Congrats! You do not have any issues with your unique validations - all the indexes are fine!\n"
      puts "Quick recommendation: you may consider move unique validations to DB level.\n"
      puts "More info in the article https://medium.com/@igorkhomenko/rails-make-sure-you-have-proper-db-indexes-for-your-models-unique-validations-ffd0364df26f"
    end
  else
    puts "You do not have any unique validations in your project so you are fine."
  end

  puts

end
