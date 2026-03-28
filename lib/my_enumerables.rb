module Enumerable
  # Your code goes here
  def my_all?
    self.my_each { |elem| return false unless block_given? ? yield(elem) : elem }
    true
  end

  def my_any?
    self.my_each { |elem| return true if block_given? ? yield(elem) : elem }
    false
  end

  def my_count(arg = nil)
    count = 0
    case 
    when block_given?
      self.my_each { |elem| count += 1 if yield elem }
      count
    when arg.nil?
      self.length
    else 
      self.my_each { |elem| count += 1 if arg == elem }
      count
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    idx = 0
    self.my_each do |elem| 
      yield elem, idx
      idx += 1
    end
    self
  end

  def my_inject(arg)
    sum = arg
    self.my_each { |elem| sum = yield sum, elem }
    sum
  end

  def my_map
    return to_enum(:my_map) unless block_given?
    array = []
    self.my_each { |elem| array << yield(elem) }
    array
  end

  def my_none?
    self.my_each { |elem| return false if block_given? ? yield(elem) : elem }
    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    array = []
    self.my_each { |elem| array << elem if yield elem }
    array
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    self.length.times { |i| yield self[i] }
    return self
  end
end
