require "unique_validation_inspector/version"

module UniqueValidationInspector
  class Inspector
    VERSION = UniqueValidationInspector::VERSION

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load File.join(File.dirname(__FILE__), 'tasks/inspect_unique_validations.rake')
      end
    end

    def initialize(app)
      @app = app
      load_models
    end

    def defined_unique_validations
      ActiveRecord::Base.descendants.reject do |model|
        if model.abstract_class?
          true
        else
          validators = model.validators.select {|v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
          validators.empty?
        end
      end.collect do |model|
        validators = model.validators.select {|v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
        {:model => model,  :validators => validators}
      end

    end

    def defined_unique_indexes(table_name, fields, scope)
      #https://dev.mysql.com/doc/refman/5.7/en/multiple-column-indexes.html

      columns = []
      columns += fields
      columns.unshift(scope) if scope
      ActiveRecord::Base.connection.indexes(table_name.to_sym).any? { |i| [lambda { |i| i.columns == columns.map(&:to_s) }].all? { |check| check[i] } }
    end

    private

    # Since Rails doesn't load classes unless it needs them, we must read the models from the folder.
    def load_models
      Dir[Rails.root.to_s + '/app/models/**/*.rb'].each do |file|
        begin
          require file
        rescue
        end
      end
    end

  end
end
