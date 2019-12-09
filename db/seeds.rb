# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'csv'
require 'rgeo/geo_json'

geo_parser = RGeo::WKRep::WKTParser.new()

puts "Processing department's data"

departments_csv = CSV.parse(File.read('db/seed_data/departments.csv'), headers: true)

departments_csv.each do |dep|
  geometry =  geo_parser.parse(dep['geometry'])
  Department.create(
    name: dep['NOMBRE_DPT'],
    code: dep['DPTO'],
    area: dep['AREA'],
    perimeter: dep['PERIMETER'],
    hectares: dep['HECTARES'],
    region: dep['region'],
    geometry: geometry
  )
end

puts "processing crops metrics"

crops_csv = CSV.parse(File.read('db/seed_data/crops.csv'), headers: true)

crops_csv.each do |row|
  type_name = "#{row['SUBGRUPO DE CULTIVO'].downcase.split(' ').join('_')}_crop"
  type = MetricType.create_with(units: 'hectares').find_or_create_by(name: type_name)
  dpt = Department.find_by(name: row['DEPARTAMENTO'])
  Metric.create(
    department: dpt,
    type: type,
    value: row['Área Sembrada(ha)'],
    year: Date.new(row['PERIODO'].to_i)
  )
end

puts "processing coca's data"

coca_csv = CSV.parse(File.read('db/seed_data/coca.csv'), headers: true)

coca_type = MetricType.create(name: 'coca_crop', units: 'hectares')

coca_csv.each do |row|
  dep = Department.find_by(name: row['DEPARTAMENTO'])
  2003.upto(2018) do |year|
    Metric.create(
      department: dep,
      type: coca_type,
      value: row[year.to_s],
      year: Date.new(year)
    )
  end
end

puts "processing conflict metrics"

conflict_csv = CSV.parse(File.read('db/seed_data/conflict.csv'), headers: true)

conflict_types = {
  terrorist_attacks: MetricType.create(name: 'terrorist_attack', units: 'quantity'),
  atentados: MetricType.create(name: 'attempt', units: 'quantity'),
  masacres: MetricType.create(name: 'slaughter', units: 'quantity'),
  reclutamiento: MetricType.create(name: 'recruitment', units: 'quantity'),
  secuestro: MetricType.create(name: 'kidnapping', units: 'quantity'),
  conflict_intensity: MetricType.create(name: 'conflict_intensity', units: 'quantity')
}

conflict_csv.each do |row|
  dpt = Department.find_by(name: row['DPTO'])
  conflict_types.each do |ref, type|
    Metric.create(
      department: dpt,
      type: type,
      value: row[ref].to_i,
      year: Date.new(row['Year'].to_i)
    )
  end
end

puts "processing displacement's data"

displacement_csv = CSV.parse(File.read('db/seed_data/displacements.csv'), headers: true)

displacement_type = MetricType.create(name: 'displacement', units: 'people')

displacement_csv.each do |row|
  dpt = Department.find_by(name: row['Departamento'])
  Metric.create(
    department: dpt,
    type: displacement_type,
    value: row['total_displacements'].to_i,
    year: Date.new(row['Year'].to_i)
  )
end

puts "processing mining data"

mining_csv = CSV.parse(File.read('db/seed_data/mineria.csv'), headers: true)

mining_type = MetricType.create(name: 'mining', units: 'tons')

mining_csv.each do |row|
  dpt = Department.find_by(name: row['Departamento'])
  Metric.create(
    department: dpt,
    type: mining_type,
    value: row['Cantidad Producción'],
    year: Date.new(row['Año Produccion'].to_i)
  )
end

puts "processing petroleum data"

petroleum_csv = CSV.parse(File.read('db/seed_data/petroleum.csv'), headers: true)

petroleum_type = MetricType.create(name: 'petroleum', units: 'tons')

petroleum_csv.each do |row|
  dpt = Department.find_by(name: row['DEPARTAMENTO'])
  2013.upto(2017) do |year|
    Metric.create(
      department: dpt,
      type: petroleum_type,
      value: row[year.to_s],
      year: Date.new(year)
    )
  end
end

puts "processing population data"

population_csv = CSV.parse(File.read('db/seed_data/population.csv'), headers: true)

population_type = MetricType.create(name: 'population', units: 'people')

population_csv.each do |row|
  dpt = Department.find_by(name: row['Category'])
  2003.upto(2018) do |year|
    Metric.create(
      department: dpt,
      type: population_type,
      value: row[year.to_s],
      year: Date.new(year)
    )
  end
end

puts "processing tree cover data"

tree_cover_csv = CSV.parse(File.read('db/seed_data/tree_cover.csv'), headers: true)

tree_cover_type = MetricType.create(name: 'tree_cover', units: 'hectares')

tree_cover_csv.each do |row|
  dpt = Department.find_by(name: row['subnational1'])
  2001.upto(2018) do |year|
    Metric.create(
      department: dpt,
      type: tree_cover_type,
      value: row[year.to_s],
      year: Date.new(year)
    )
  end
end

puts "processing weather data"

weather_csv = CSV.parse(File.read('db/seed_data/weather.csv'), headers: true)

weather_type = MetricType.create(name: 'weather', units: '°C')

weather_csv.each do |row|
  dpt = Department.find_by(name: row['Departamento'])
  Metric.create(
    department: dpt,
    type: weather_type,
    value: row['MeanTemp']
  )
end