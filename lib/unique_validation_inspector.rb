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
      ActiveRecord::Base.descendants.map do |model|
        [model.name,  model.validators.select {|v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }]
      end
    end

    # def defined_unique_indexes
    #
    # end

  end
end
