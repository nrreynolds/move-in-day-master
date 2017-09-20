# class for a building
class Building
  # be able to read apartments and address
  attr_reader :apartments, :address

  # init building
  def initialize(address, number_of_floors)
    # set class variables
    @address = address
    @number_of_floors = number_of_floors
    @apartments = []
  end

  # method to add an apartement to the building
  def add(floor, apartment)
    # if the floor does not exist
    if floor > @number_of_floors || floor < 1
      # return a message
      return "Floor #{floor} out of range"
    end
    # add hash for the apartment with the apartment and the floor number
    @apartments << {:apartment => apartment, :floor => floor}
    # return the building - so that it can be chained
    self
  end

  # to get the apartments on a floor
  def floor(floor_number)
    # if the floor doesn't exist
    if floor_number > @number_of_floors || floor_number < 1
      # return a message
      return "Foor #{floor_number} out of range"
    end

    # select only the apartment hashes that have the given floor
    # then collect the apartments into an array without the floor
    @apartments.select{|apt| apt[:floor] == floor_number}.collect{|apt| apt[:apartment]}

  end

  # method to get the total of all the rents
  def collect_rents
    # collect an array of all the apartment prices
    # then reduce them to one number
    @apartments.collect{ |apt| apt[:apartment].price }.reduce(:+)
  end

  # method to see if there are vacancies
  def vancancies?
    # collect an array of apartments' fullness
    # see if any of them are not full
    @apartments.collect{|apt|apt[:apartment].full?}.include?(false)
  end

  # method to return a terminal rendering of the building
  def get_building_render
    # start with a range of floors in the building
    # collect the floor render for each floor
    # reverse it so the building is rendered in the right direction
    (1..@number_of_floors).collect{ |floor_number| get_floor_render(floor_number) }.reverse
  end

  # methods that are not needed outside of this class
  private
    # method that produces an array of apartments for each floor
    def floors
      # start with a range of all the floors
      # collect a hash of the apartments on that floor and the floor number
      (1..@number_of_floors).collect{ |floor_number| {:apartments=>floor(floor_number), :floor=>floor_number}}
    end

    # method to get the render of a given floor
    def get_floor_render(floor_number)
      # get the amount of apartments on the floor
      apt_amount = floor(floor_number).size
      # variable with an array of each line of a apartment (a window)
      apt_render = [" ____  ", "|    | ", "|____| ", "_______"]
      # the array for the first floor window
      first_floor_apt_render = [" ____  ", "|    | ", "|____| ", "======="]
      # the array for the door
      door_render = [" ____  ", "|    | ", "|   ^| ", "======="]
      # width of each line of the apartment window
      apt_width = apt_render[0].size

      # figure out what the max apartments on a floor of a building is
      # get all the floors group by the amount of apartments per floor
      max_apts = floors.group_by do |floor|
        # get the amount of apartments on the floor
        size = floor[:apartments].size
        # if its the first floor
        if floor[:floor] == 1
          # add 1 to account for the door
          size +=1
        end
        # return the size
        size
      end
      # get the max amount of apartments by using the keys of the group by
      max_apts = max_apts.keys.max { |a, b| a<=>b }

      # figure out the max width of a given floor
      # basically each floor isn't going to have the same amount of apartments
      # so this helps make sure each floor is the same width
      max_width = max_apts * apt_width

      # initiate the array that has each line of the floor's render
      floor_render = (1..4).collect {|floor| "" }

      # if its floor 1
      if floor_number == 1
        # add some ground to the bottom row of the render
        floor_render[3] = "======="
      end

      # get each of the lines for the floor with the index
      floor_render.each_with_index do |floor_segment, index|
        # for each in the range of apartments
        (1..apt_amount).each do |apt|
          # if it is the first floor
          if floor_number == 1
            # add the line from the first floor apt array
            floor_segment << first_floor_apt_render[index]
            # if it is the middle of the first floor
            if (apt_amount/2).floor == apt || (apt_amount/2).floor == 0
              # add the line from the door array
              floor_segment << door_render[index]
            end
          else # if it is not the first floor
            # add the line from the apt array
            floor_segment << apt_render[index]
          end
        end
        # default white space to add
        character_add = " "
        # if it is the bottom row
        if index==3
          # white space character is an underdash
          character_add = "_"
          # if it is the first floor and the bottom row
          if floor_number == 1
            # the white space character is a =
            character_add = "="
          end
        end

        # keep track what side its adding to to center the apts
        add_to_front = false
        # while its shorter than the max width
        while floor_segment.size < max_width do
          # if it is adding to the front
          if add_to_front
            # add the white space in front of the floor segment
            floor_segment = "#{character_add}#{floor_segment}"
          else #if its adding to the end
            # add the white space to the end of the floor segment
            floor_segment<<character_add
          end
          # switch which side its adding to
          add_to_front = !add_to_front
        end

        # if it is not the last row of the first floor
        if floor_number != 1 || (floor_number == 1 && index != 3)
          # add the walls of the building
          floor_segment = "  |#{index==3? "_": " "}#{floor_segment}|  "
          # if there isn't enough ground below the building
        elsif floor_segment.size < max_width + 6
          # add some!
          floor_segment = "=======#{floor_segment}"
        end
        # for some reason by the end of this, the floor segment isn't the same
        # as the one in the floor renderer...
        floor_render[index] = floor_segment
      end

      # if it is the top floor
      if floor_number == @number_of_floors
        # add the roof!
        floor_render.unshift("   #{(1..max_width).collect{|udash| "_"}.join("")}_")
      end
      # return the floor render
      floor_render
    end

end
