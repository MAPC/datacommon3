class SearchFacade

  attr_accessor :results

  def initialize(results)
    @results = results
  end

  def classes
    @results.collect {|r| r.class.to_s }.uniq
  end

  def method_missing(method)
    @results.select {|r| r.class.to_s == method.to_s.classify }
  end

end