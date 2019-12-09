class MetricSerializer < ActiveModel::Serializer
  attributes :value, :year
  attribute :units do
    object.type.units
  end
  attribute :department do
    object.department.name
  end
  attribute :type do
    object.type.name
  end
end