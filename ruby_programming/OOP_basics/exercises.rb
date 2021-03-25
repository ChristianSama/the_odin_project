# module Towable
#   def tow(object)
#     puts "you are towing #{object}!"
#   end
# end

# class Vehicle
#   @@vehicles_created = 0

#   attr_accessor :color
#   attr_reader :year, :model
#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@vehicles_created += 1
#     puts "You bought your #{color} #{year} #{model}"
#   end
  
#   def self.number_of_vehicles
#     puts "Vehicles created: #{@@vehicles_created}"
#   end

#   def self.calc_gas_mil(gallons, miles)
#     puts "#{miles/gallons} miles per gallon of gas"
#   end

#   def speed_up(mph=10)
#     @speed += mph
#     puts "You are going at #{@speed} mph"
#   end

#   def brake(mph=10)
#     @speed -= mph
#     puts "You slowed down to #{@speed} mph"
#   end

#   def shut_off
#     @speed = 0
#     puts "Turned off car"
#   end

#   def spray_paint(color)
#     self.color = color
#     puts "You painted your car to #{color}"
#   end

#   def to_s
#     "Your car is a #{color} #{year} #{@model}"
#   end

#   def get_age 
#     puts "Your car is #{calc_age} years old"
#   end

#   private
#   def calc_age
#     Time.now.year - self.year.to_i
#   end
# end

# class MyCar < Vehicle
#   NUMBER_OF_DOORS = 4
  
# end

# class MyTruck
#   NUMBER_OF_DOORS = 2
#   include Towable
# end

# new_car = MyCar.new("1967", "gray", "mustang")
# asdfasdf = MyCar.new("123", "red", "toyota")
# my_truck = MyTruck.new
# my_truck.tow("tree")
# #puts MyTruck.ancestors
# new_car.speed_up(60)
# new_car.brake(20)
# new_car.shut_off
# p new_car.color
# p new_car.year
# new_car.color = 'blue'
# p new_car.color
# new_car.spray_paint("black")
# MyCar.calc_gas_mil(10, 100)
# #puts new_car
# new_car.get_age
# Vehicle.number_of_vehicles

# class Student

#   attr_accessor :name

#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(student)
#     grade > student.grade
#   end

#   protected
#   attr_accessor :grade
# end

# joe = Student.new("Joe", 7)
# juan = Student.new("Juan", 6)
# puts "Well Done" if joe.better_grade_than?(juan)


class Viking
  attr_accessor :name, :age, :health, :strength

  def initialize(name, age, health, strength)
    @name = name
    @age = age
    @health = health
    @strength = strength
  end

  def print_name
    p name
  end

end

olaf = Viking.new("Olaf", 20, 100, 7)

olaf.print_name
