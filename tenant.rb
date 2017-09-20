# require the date library
require 'date'

# create a tenant class
class Tenant
  # be able to read and write nickname and occupation
  attr_accessor :nickname, :occupation
  # be able to just read born on
  attr_reader :born_on

  # init the tenant
  def initialize (f_name, l_name, gender, born_on)
    # assign all the class variables
    @f_name = f_name
    @l_name = l_name
    # https://ruby-doc.org/stdlib-2.3.1/libdoc/date/rdoc/Date.html
    @born_on = Date.parse(born_on)
    @gender = gender
  end

  # method to get the full name
  def full_name
    # string interpolation
    "#{@f_name}#{@nickname ? " '#{@nickname}' ":" "}#{@l_name}"
  end

  # method to get the age of the tenant
  def age
    # get this year, subtract the year they were born
    Date.today().year - @born_on.year
  end

end
