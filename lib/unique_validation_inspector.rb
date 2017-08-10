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

    def defined_unique_validations
      ActiveRecord::Base.descendants.reject do |model|
        validators = model.validators.select {|v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
        validators.empty?
      end.collect do |model|
        validators = model.validators.select {|v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
        [model,  validators]
      end

    end

    def defined_unique_indexes(table_name, fields, scope)
      #https://dev.mysql.com/doc/refman/5.7/en/multiple-column-indexes.html
      
      columns = []
      columns += fields
      columns.unshift(scope) if scope
      ActiveRecord::Base.connection.indexes(table_name.to_sym).any? { |i| [lambda { |i| i.columns == columns.map(&:to_s) }].all? { |check| check[i] } }
    end

  end
end
