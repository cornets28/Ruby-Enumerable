module Enumerable #module begins

    def my_each #my_each method begins
        index = 0
        while  index < self.length
            yield(self[index])
             index+=1
        end 
       self
    end #my_each method end
  

    def my_each_with_index #my_each_with_index method begins
        index = 0
        while  index < self.length #
            yield(self[index], index)
             index+=1
        end 
    end #my_each_with_index  method begins


    def my_select #my_select method begins
        result_array = []
        
        self.my_each do |i|
          yield(i) ? result_array.push(i) : result_array
         end 
      end #my_select method ends


    def my_all? #my_all method begins
       self.my_each { |i|
         if !yield(i)
           return false
         end
       }
       return true
    end #my_all method ends

    def my_any #my_any method begins
        status = false
        array = []
        self.my_each do |i|
          if yield(i)
            status = true
          end
        end
        status
    end #my_any method ends

    def my_none? #my_none method begins
		((self.my_any { |i| yield(i) == true }) == true) ? false : true 
    end # my_none method ends
    
  
    def my_inject startingPoint #my_inject method begins
        self.my_each{|i| startingPoint = yield(startingPoint, i)}
        startingPoint
    end #my_inject method ends
    

    def my_count(arg=nil) #my_count method begins
        truth_array = []
    
        (arg != nil) ? self.my_each { |element| truth_array << element if arg == element } :
        (block_given? == false) ? self.my_each { |element| truth_array << element }:
        self.my_each { |element| truth_array << element if yield(element) }
    
        truth_array.length
    end #my_any method ends

    def my_map(proc=nil) #my_map method begins
        mapped_array = []
    
        if proc
          self.my_each do |el|
            mapped_array << proc.call(el)
          end
        elsif proc.nil? && block_given?
          self.my_each do |el|
            mapped_array << yield(el)
          end
        end
       
        mapped_array
      end #my_map method ends

end #module ends



# Testing our methods
arr = [3,-2,6,11,4]
arr2 = ["Daniel","US","Cat" "VolleyBall"]

puts "MY_EACH"
arr.my_each { |number| puts number-1 }
puts "........"

puts "MY_EACH_WITH_INDEX"
arr.my_each_with_index { |number, itemPosition| puts "#{itemPosition}: #{number*5}"}
puts "........"

puts "MY_SELECT"
arr.my_select { |number| puts number + 2}
puts "........"

puts "MY_ALL"
puts arr2.all?
puts arr2.my_all? { |i| i}
puts "........"

puts "MY_ANY"
p arr2.my_any {|a| a.length >= 7}
puts "........"

puts "NONE"
puts arr.my_none? { |x| x == 0 }
puts arr.my_none? { |x| x == 3 }
puts "........"

puts "INJECT.............................................."
puts arr.inject { |sum,x| sum += x }
puts arr.my_inject(0) { |sum,x| sum += x }
puts "........"

puts "MAP"
puts arr.my_map { |x| x.to_s + "!" }.to_s
puts "....."

puts "My_COUNT:"
puts arr.my_count
puts "Ruby is fun!".split("").my_count
puts "....."

puts "MULTIPLES_ELS"
def multiply_els(arr)
	arr.my_inject(1) { |x,num|  x *= num }
end
puts multiply_els([2,4])
puts "....."

puts "MY_MAP with proc"
multiply_by_4 = Proc.new { |number| number *= 4 }
multiply_by_3 = Proc.new { |number| number *= 3}
singleNumber = Proc.new { |number| "This number is #{number}." }
puts arr.my_map(& multiply_by_4).to_s
puts arr.my_map(& multiply_by_3).to_s
puts arr.my_map(& singleNumber)