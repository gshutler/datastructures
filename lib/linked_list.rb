module DataStructures

  # Error raised when a request it made with an index outside the valid range
  # for the data structure
  class IndexOutOfRange < StandardError; end

  # Implementation of a doublely linked list
  class LinkedList

    # Retrieve the size of the linked list <tt>O(1)</tt>
    attr_reader :size
  
    # Create a new, empty list
    def initialize
      @head = nil
      @tail = nil
      @size = 0
    end
  
    # Append a new value to the end of the list <tt>O(1)</tt>
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
    
    # Retrieve the value at the specified index <tt>O(n)</tt>
    # 
    # Raises IndexOutOfRange if index is not #in_range?
    def get(index)      
      assert_in_range index
      node = get_node(index)
      node.value
    end
    
    # Insert the value at the given index <tt>O(n)</tt>
    #
    # Raises IndexOutOfRange if index is not #in_range? and does not equal #size
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
    
    # Remove the value at the given index <tt>O(n)</tt>
    #
    # Raises IndexOutOfRange if index is not #in_range?
    def remove(index)
      assert_in_range index
      
      current = get_node(index)
      current.ancestor.successor = current.successor if current.ancestor
      current.successor.ancestor = current.ancestor if current.successor
      
      @head = current.successor if current == @head
      @tail = current.ancestor if current == @tail
      
      @size -= 1
    end
    
    # Determine whether the list is empty <tt>O(1)</tt>
    def empty?
      @size == 0
    end
    
    # Invoke &block for each value in the list <tt>O(n)</tt> in the order they
    # appear
    def each(&block)    
      current = @head
      
      while current
        block.yield current.value
        current = current.successor
      end
    end
    
    # Create a new list that contains all the value in the current list but in 
    # the reverse order
    def reverse
      reversed = LinkedList.new   
      each_reverse {|v| reversed.append(v)}
      reversed
    end
        
    # Determines whether the index is greater than or equal to <tt>0</tt> and 
    # less than #size
    def in_range?(index)
      index >= 0 and index < size
    end
        
    private
    
    # Invoke &block for each value in the list <tt>O(n)</tt> in the reverse 
    # order to that which they appear <tt>O(n)</tt>
    def each_reverse(&block)
      current = @tail
      
      while current
        block.yield current.value
        current = current.ancestor
      end
    end
    
    # Retrieve the node at the given index, returns <tt>nil</tt> if the index is
    # not #in_range? <tt>O(n)</tt>
    def get_node(index)
      return nil if index < 0 or index >= @size
    
      current = @head
      current_index = 0
      
      while current_index < index and current
        current = current.successor
        current_index += 1
      end
      current
    end
    
    # Raises IndexOutOfRange if index is not #in_range?
    def assert_in_range(index)
      raise IndexOutOfRange unless in_range? index
    end
    
    # Internal data structure for representing nodes in the list
    class LinkedListNode # :nodoc:
      
      attr_accessor :ancestor, :successor
      attr_reader :value
    
      def initialize(args)
        @ancestor = args[:ancestor]
        @successor = args[:successor]
        @value = args[:value]
      end
    
    end
    
  end  

end
