# create class for apartment
class Apartment
  # make tenants readable
  attr_reader :tenants

  #init the apartment
  def initialize(unit, num_beds, num_baths)
    # assign class variables
    @unit = unit
    @num_beds = num_beds
    @num_baths = num_baths
    @tenants = []
  end

  # method to get the price of the apt
  def price
    # 100 for each bed, 500 for each bath
    (1000 * @num_beds) + (500 * @num_baths)
  end

  # check if it is a studio
  def studio?
    # return if there is only 1 bedroom
    @num_beds == 1
  end

  # check if it is full
  def full?
    # if there are the same amount of tenants as beds
    @tenants.size == @num_beds
  end

  # check if it is empty
  def empty?
    # if there are no tenants
    @tenants.size == 0
  end

  # move a tenant in to an apartment
  def move_in(tenant)
    # if the apartment is full
    if full?
      # return a message
      return "We're full! #{tenant.full_name} can't move in!"
    end
    # if it isn't full, add the tenant
    @tenants<<tenant
    # return itself for chaining
    self
  end

end
