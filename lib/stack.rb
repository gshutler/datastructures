module DataStructures

  # Implementation of a stack
  class Stack
  
    # Retrieve the size of the stack.
    # 
    # <tt>O(1)</tt>
    # 
    # @return [Integer] 
    #   The size of the stack
    attr_reader :size
  
    # Create a new, empty stack
    def initialize
      @size = 0
      @top = nil
    end
    
    # Push a new value onto the stack.
    # 
    # <tt>O(1)</tt>
    #
    # @param [Object] value
    #   The value to push onto the stack
    def push(value)
      new_top = StackNode.new(:parent => @top, :value => value)
      @top = new_top
      @size += 1
    end
    
    # Pop the value off the top of the stack.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   The value at the top of stack
    #
    # @raise [IndexOutOfRange]
    #   When the stack is #empty?
    def pop
      assert_not_empty
          
      value = @top.value
      @top = @top.parent
      @size -= 1
      
      value
    end
    
    # Peek at the value from the top of the stack.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   The value at the top of stack
    #
    # @raise [IndexOutOfRange]
    #   When the stack is #empty?
    def peek
      assert_not_empty
      
      @top.value
    end
    
    # Determine whether the stack is empty.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   <tt>true</tt> if the stack is empty, otherwise <tt>false</tt>
    def empty?
      @size == 0
    end
  
    private

    # Raise IndexOutOfRange when the stack is #empty?.
    #
    # <tt>O(1)</tt>
    #
    # @raise [IndexOutOfRange]
    #   When the stack is #empty?
    def assert_not_empty
      raise IndexOutOfRange if empty?
    end
   
    # Data structure for storing the nodes in the stack.
    # 
    # @private
    class StackNode
    
      attr_reader :parent, :value
    
      def initialize(args)
        @parent = args[:parent]
        @value = args[:value]
      end
    
    end
  
  end

end
