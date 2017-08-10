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
        [model.name,  validators]
      end

    end

    # def defined_unique_indexes
    #
    # end

  end
end
