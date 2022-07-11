
class Stack
    def initialize
        @var = []
      # create ivar to store stack here!
    end

    def push(el)
        @var.append(el)
      # adds an element to the stack
    end

    def pop
        @var.pop
      # removes one element from the stack
    end

    def peek
        @var[-1]
      # returns, but doesn't remove, the top element in the stack
    end
end

class Que
    def initialize
        @list= [] 
    end

    def enque(el)
        @list.unshift(el)
    end

    def deque
        @list.pop
    end

    def peek
        @list[-1]
    end

end

class Map
    def initialize
        @list= []
    end

    def set(key,val)
        isunique= true
        @list.each do |item|
            if item[0] == key
                isunique = false
            end
        end
        if isunique== true
            @list.append [key,val]
        end
    end

    def get(key)
        @list.each do |item|
            if item[0] == key
                return item[1]
            end
        end
    end

    def delete(key)
        @list.each_with_index do |item, idx|
            if item[0] == key
                @list.delete_at(idx)
            end
        end
    end

    def show
        print @list  
    end
end

