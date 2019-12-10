module Api
  class MetricController < ApplicationController
    def index
      @metrics = Metric.all.includes(:department, :type)
      render json: @metrics
    end

    def by_type
      metrics_type = MetricType.find_by(name: params[:type])
      @metrics = Metric.where(type: metrics_type).includes(:department, :type)
      render json: @metrics
    end

    def by_type_and_year
      metrics_type = MetricType.find_by(name: params[:type])
      year_date = Date.new(params[:year].to_i)
      @metrics = Metric.where(type: metrics_type, year: year_date).includes(:department, :type)
      render json: @metrics
    end
  end
end