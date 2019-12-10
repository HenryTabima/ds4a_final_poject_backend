require 'rgeo/geo_json'
module Api
  class DepartmentController < ApplicationController
    def index
      @departments = Department.all
      res = @departments.map do |department|
        department.geometry = RGeo::GeoJSON.encode(department.geometry)
        department
      end
      render json: res
    end
  end
end