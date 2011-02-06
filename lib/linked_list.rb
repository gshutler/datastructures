module DataStructures

  # Error raised when a request it made with an index outside the valid range
  # for the data structure
  class IndexOutOfRange < StandardError; end

  # Implementation of a linked list
  class LinkedList

    # Retrieve the size of the list <tt>O(1)</tt>.
    #
    # @return [Integer] 
    #   The size of the list
    attr_reader :size
  
    # Create a new, empty list
    def initialize
      @head = nil
      @tail = nil
      @size = 0
    end
  
    # Append a new value to the end of the list <tt>O(1)</tt>.
    #
    # @param value 
    #   The value to append to the list
    def append(value)
      if @size == 0
        @head = @tail = LinkedListNode.new(:value => value)
      else
        old_tail = @tail
        @tail = LinkedListNode.new(:value => value)
        old_tail.successor = @tail
      end
      @size += 1
    end
    
    # Retrieve the value at the specified index <tt>O(n)</tt>.
    #
    # @param [Integer] index
    #   The index to retrieve the value for
    # 
    # @raise [IndexOutOfRange]
    #   When index is not #in_range?
    def get(index)      
      assert_in_range index
      node, previous = get_node(index)
      node.value
    end
    
    # Insert the value at the given index <tt>O(n)</tt>.
    #
    # @param [Integer] index
    #   The index to retrieve the value for
    # @param value
    #   The value to insert into the list
    #        
    # @raise [IndexOutOfRange]
    #   When index is not #in_range? and does not equal #size
    def insert(index, value)
      if index == @size
        append(value)
      else
        assert_in_range(index)
        
        current, previous = get_node(index)
        inserted = LinkedListNode.new(:successor => current, :value => value)
        previous.successor = inserted if previous
        
        @head = inserted if current == @head                
        @size += 1
      end
    end
    
    # Remove the value at the given index <tt>O(n)</tt>.
    # 
    # @param [Integer] index
    #   The index to remove from the list
    #
    # @raise [IndexOutOfRange]
    #   When index is not #in_range?
    def remove(index)
      assert_in_range index
      
      current, previous = get_node(index)
      previous.successor = current.successor if previous
      
      @head = current.successor if current == @head
      @tail = previous if current == @tail
      
      @size -= 1
    end
    
    # Determine whether the list is empty <tt>O(1)</tt>.
    #
    # @return [Object] <tt>true</tt> if the list is empty, otherwise <tt>false</tt>
    def empty?
      @size == 0
    end
    
    # Invoke &block for each value in the list <tt>O(n)</tt> in the order they
    # appear.
    #
    # @param [Proc] block
    #   The proc to invoke for each value in the list
    def each(&block)    
      current = @head
      
      while current
        block.call(current.value)
        current = current.successor
      end
    end
    
    # Create a new list that contains all the value in the current list but in 
    # the reverse order.
    #
    # @return [LinkedList]
    #   A new list that contains all the value in the current list but in 
    #   reverse order
    def reverse
      reversed = LinkedList.new   
      each {|v| reversed.insert(0, v)}
      reversed
    end
        
    # Determines whether the index is greater than or equal to <tt>0</tt> and 
    # less than #size.
    #
    # @param [Integer] index
    #   The index to check for range compliance
    def in_range?(index)
      index >= 0 and index < size
    end
        
    private
        
    # Retrieve the node at the given index, returns <tt>nil</tt> if the index is
    # not #in_range? <tt>O(n)</tt>.
    #
    # @param [Integer] index
    #   The index to retrieve the node for
    # 
    # @return [LinkedListNode, LinkedListNode]
    #   The node at the given index and it's ancestor or if the index is not 
    #   #in_range and greater than #size
    def get_node(index)
      return [nil, @tail] if index == @size
      return [nil, nil] unless in_range? index
    
      previous = nil
      current = @head
      current_index = 0
      
      while current_index < index and current
        previous = current
        current = current.successor
        current_index += 1
      end
      
      [current, previous]
    end
    
    # Raises IndexOutOfRange if index is not #in_range?
    #
    # @param [Integer] index
    #   The index to check for #in_range compliance
    #
    # @raise [IndexOutOfRange]
    #   When index is not #in_range
    def assert_in_range(index)
      raise IndexOutOfRange unless in_range? index
    end
    
    # Internal data structure for representing nodes in the list
    # @private
    class LinkedListNode # :nodoc:
      
      attr_accessor :successor
      attr_reader :value
    
      def initialize(args)
        @successor = args[:successor]
        @value = args[:value]
      end
    
    end
    
  end  

end
