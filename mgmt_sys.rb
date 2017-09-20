# notes (trying to help if this will be used on future classes):
# Person.new was used instead of Tenant.new in 6 and 7.1
# in part 7.2 only one person moves in to a 2 bedroom apartment,
# it should not be full but the assignment said the expected output is full
# in 9.4 the result should be 5500
# in 10.2 the result should be for the current year ie: 76

# http://rubylearning.com/satishtalim/including_other_files_in_ruby.html
# require all of my files
require_relative 'tenant'
require_relative 'apartment'
require_relative 'building'

# Part 1
$stdout.puts "================== PART 1 =================="
p1 = Tenant.new("Calvin", "Clifford", "male", "December 21st, 1929")
p1.nickname = "Bud"
p1.occupation = "Office Drone"

$stdout.puts p1.nickname
$stdout.puts p1.occupation

# Part 2
$stdout.puts "================== PART 2 =================="
$stdout.puts p1.full_name

# Part 3
$stdout.puts "================== PART 3 =================="
a1 = Apartment.new("B", 2, 1)
$stdout.puts a1.inspect

# Part 4
$stdout.puts "================== PART 4 =================="
a2 = Apartment.new("A", 2, 1)
$stdout.puts a2.price

# Part 5
$stdout.puts "================== PART 5 =================="
a1 = Apartment.new("B", 2, 1)
a2 = Apartment.new("A", 1, 1)
$stdout.puts a1.studio? #=> false
$stdout.puts a2.studio? #=> true

# Part 6
$stdout.puts "================== PART 6 =================="
a1 = Apartment.new("B", 1, 1)
p1 = Tenant.new("Fran", "Kubelik", "female", "May 8, 1935")
$stdout.puts a1.move_in(p1).inspect
$stdout.puts a1.tenants
$stdout.puts a1.tenants.class    #=> Array < Object
$stdout.puts a1.tenants[0].class #=> Tenant < Object
$stdout.puts a1.tenants.size     #=> 1

# Part 7
$stdout.puts "================== PART 7 =================="
a1 = Apartment.new("B", 1, 1)
a1.empty? #=> true
p1 = Tenant.new("Fran", "Kubelik", "female", "May 8, 1935")
a1.move_in(p1)
$stdout.puts a1.empty? #=> false

a2 = Apartment.new("B", 2, 1)
p1 = Tenant.new("Al", "Kirkeby", "male", "January 23, 1949")
p2 = Tenant.new("Karl", "Matuschka", "male", "June 27, 1949")
$stdout.puts a2.empty? #=> true
a2.move_in(p1)
$stdout.puts a2.empty? #=> false
# **note: if only one person moves into a 2 bedroom apartment, it is not full,
# so the expected output is actually false
$stdout.puts a2.full?  #=> true WRONG
a2.move_in(p2)
$stdout.puts a2.full?  #=> true

# Part 8
$stdout.puts "================== PART 8 =================="
p1 = Tenant.new("Mildred", "Dreyfuss", "female", "July 18, 1942")
p2 = Tenant.new("Jeff", "Sheldrake", "male", "November 18, 1941")
p3 = Tenant.new("Joe", "Dobisch", "male", "May 17, 1939")
a3 = Apartment.new("F", 2, 1)
a3.move_in(p1)
a3.move_in(p2)
$stdout.puts a3.full?        #=> true
$stdout.puts a3.move_in(p3)  #=> "We're full! Joe Dobisch can't move in"
$stdout.puts a3.tenants.size #=> 2

# Part 9
$stdout.puts "================ PART BONUS ================"
# 9.1
b1 = Building.new("208 Leonard St", 3)
$stdout.puts b1.apartments.inspect #=> []

# 9.2
a1 = Apartment.new("B", 2, 1)
a2 = Apartment.new("A", 1, 1)
a3 = Apartment.new("A", 1, 1)

# Specifiy the floor and apartment object
b1.add(1, a1)
b1.add(1, a2)
b1.add(2, a3)

# 9.3
$stdout.puts b1.floor(1).inspect #=> [<#Apartment:01>, <#Apartment:02>]
$stdout.puts b1.floor(2).inspect #=> [<#Apartment:03>]

# 9.4
$stdout.puts b1.collect_rents #=>  1000000 - not actually the total of the rents

# 9.5
b1 = Building.new("208 Leonard St", 3)
p1 = Tenant.new("Al", "Kirkeby", "male", "January 23, 1949")
a1 = Apartment.new("B", 2, 1)
a1.move_in(p1)
$stdout.puts b1.vancancies? #=> true

# Part 10
$stdout.puts "=============== PART BONUS 2 ==============="
p1 = Tenant.new("Mildred", "Dreyfuss", "female", "July 18, 1942")
$stdout.puts p1.born_on.class #=> Date < Object

p2 = Tenant.new("Jeff", "Sheldrake", "male", "November 18, 1941")
$stdout.puts p2.age #=> 73 -- actually 76


# My special bonus - render a building in the terminal!
$stdout.puts "=========== PART MY SPECIAL BONUS =========="

# This is where I was testing what it should look like in the terminal
# puts "    _______________________________    "
# puts "   |   ____   ____   ____   ____   |   "
# puts "   |  |    | |    | |    | |    |  |   "
# puts "   |  |____| |____| |____| |____|  |   "
# puts "   |   ____   ____   ____   ____   |   "
# puts "   |  |    | |    | |    | |    |  |   "
# puts "   |  |____| |____| |____| |____|  |   "
# puts "   |   ____   ____   ____   ____   |   "
# puts "   |  |    | |    | |    | |    |  |   "
# puts "   |  |____| |   ^| |____| |____|  |   "
# puts "======================================="

# get a random amount of floors between 2 and 10
floor_amout = (2..10).to_a.sample
# create a new building with that^ many floors
rendered_building = Building.new("106 Main Street", floor_amout)

# for each floor
(1..floor_amout).each do |floor_number|
  # get an array of apartment letters
  apt_letter_arr = ("a".."f").to_a
  # get how many apartments there will be (random from the apt arr)
  # since the apartments are letters, get the index to know how many
  apt_amount = apt_letter_arr.index(apt_letter_arr.sample)

  # for each apartment
  (0..apt_amount).each do |apt_num|
    # get a rondom amount of bedrooms
    br = (1..4).to_a.sample
    # get a random amount of bathrooms
    bath = (1..4).to_a.sample
    # create the apartment
    apt = Apartment.new(apt_letter_arr[apt_num], br, bath)
    # add the apartment to the building
    rendered_building.add(floor_number, apt)
  end

end

# render the building
$stdout.puts rendered_building.get_building_render
$stdout.puts "Address: #{rendered_building.address}"
