class Metric < ApplicationRecord
  belongs_to :department
  belongs_to :type, class_name: 'MetricType'
end
