class MetricType < ApplicationRecord
  has_many :metrics, foreign_key: :type_id
end
