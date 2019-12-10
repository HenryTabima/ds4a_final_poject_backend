class DepartmentSerializer < ActiveModel::Serializer
  cache key: 'department', expires_in: 9.hours
  attributes :code, :name, :area, :perimeter, :hectares, :region, :geometry
end