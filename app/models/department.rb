class Department < ApplicationRecord
  self.primary_key = :code
  has_many :metrics
  has_many :metric_types, through: :metrics, source: :type

  def metrics_by_type(type)
    self.metric_types.find_by(name: type).metrics.where(department: self)
  end
end
