require_relative 'test_helper'

class UniqueValidationInspectorTest < Minitest::Test
  def setup
    @inspector = UniqueValidationInspector::Inspector.new Rails.application
  end

  def test_defined_unique_validations
    res = @inspector.defined_unique_validations

    assert_equal 2, res.count


    assert_equal User, res.first[:model]
    assert_equal 3, res.first[:validators].count
    #
    assert_equal :application_id, res.first[:validators][0].options[:scope]
    assert_equal [:email], res.first[:validators][0].attributes
    #
    assert_equal :application_id, res.first[:validators][1].options[:scope]
    assert_equal [:login], res.first[:validators][1].attributes
    #
    assert_nil res.first[:validators][2].options[:scope]
    assert_equal [:blob_id], res.first[:validators][2].attributes


    assert_equal Application, res.last[:model]
    assert_equal 1, res.last[:validators].count
    #
    assert_equal :account_id, res.last[:validators][0].options[:scope]
    assert_equal [:title], res.last[:validators][0].attributes
  end

  def test_defined_unique_indexes
    @inspector.defined_unique_validations.each do |item|
      model = item[:model]
      item[:validators].each do |validation|
        index_exists = @inspector.defined_unique_indexes(
          model.table_name,
          validation.attributes,
          validation.options[:scope]
        )
        assert_equal false, index_exists
      end
    end
  end
end
