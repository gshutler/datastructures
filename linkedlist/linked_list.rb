module DataStructures

  class IndexOutOfRange < StandardError; end

  class LinkedList
  
    attr_reader :size
  
    def initialize
      @head = nil
      @tail = nil
      @size = 0
    end
  
    def append(value)
      if @size == 0
        @head = @tail = LinkedListNode.new(:value => value)
      else
        old_tail = @tail
        @tail = LinkedListNode.new(:ancestor => old_tail, :value => value)
        old_tail.successor = @tail
      end
      @size += 1
    end
    
    def get(index)      
      assert_in_range index
      node = get_node(index)
      node.value
    end
    
    def insert(index, value)
      if index == @size
        append(value)
      else
        assert_in_range index
        
        current = get_node(index)        
        inserted = LinkedListNode.new(:ancestor => current.ancestor, :successor => current, :value => value)
        current.ancestor.successor = inserted if current.ancestor
        current.ancestor = inserted
        
        @head = inserted if current == @head
                
        @size += 1
      end
    end
    
    def remove(index)
      assert_in_range index
      
      current = get_node(index)
      current.ancestor.successor = current.successor if current.ancestor
      current.successor.ancestor = current.ancestor if current.successor
      
      @head = current.successor if current == @head
      @tail = current.ancestor if current == @tail
      
      @size -= 1
    end
        
    def empty?
      @size == 0
    end
    
    def each(&block)    
      current = @head
      
      while current
        block.yield current.value
        current = current.successor
      end
    end
    
    def reverse
      reversed = LinkedList.new   
      each_reverse {|v| reversed.append(v)}
      reversed
    end
    
    def each_reverse(&block)
      current = @tail
      
      while current
        block.yield current.value
        current = current.ancestor
      end
    end
    
    private
    
    def get_node(index)
      current = @head
      current_index = 0
      
      while current_index < index and current
        current = current.successor
        current_index += 1
      end
      current
    end
    
    def assert_in_range(index)
      raise IndexOutOfRange unless index < @size and index >= 0
    end
           
    class LinkedListNode
    
      attr_accessor :ancestor, :successor, :value
    
      def initialize(args)
        @ancestor = args[:ancestor]
        @successor = args[:successor]
        @value = args[:value]
      end
    
    end
    
  end  

end
