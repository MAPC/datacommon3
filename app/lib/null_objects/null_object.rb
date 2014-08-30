# From Confident Ruby
# Section 4.18: Represent do-nothing cases as null objects
# by [Avdi Grimm](https://github.com/avdi)

class NullObjects::NullObject < BasicObject
  
  def method_missing(*)
  end
  
  def respond_to?(name) true
  end
end