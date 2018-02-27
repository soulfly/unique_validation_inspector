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
    end

    def load_everything!
      @app.eager_load!
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

    def defined_unique_indexes(table_name, field, scope)
      #https://dev.mysql.com/doc/refman/5.7/en/multiple-column-indexes.html
      columns = []
      columns += field
      columns = columns + Array(scope) if scope

      unique_indexes(table_name).any? do |index_def|
        columns.map(&:to_s) == index_def.columns
      end
    end

    private

    def unique_indexes(table_name)
      ActiveRecord::Base.connection.indexes(table_name.to_sym).select{|i| i.unique }
    end

  end
end
