module DataStructures

  # Implementation of a queue
  class Queue
  
    # Retrieve the size of the queue.
    # 
    # <tt>O(1)</tt>
    # 
    # @return [Integer] 
    #   The size of the queue
    attr_reader :size
  
    # Create a new, empty queue
    def initialize
      @size = 0
      @front = nil
      @back = nil
    end
    
    # Push a new value onto the back of the queue.
    # 
    # <tt>O(1)</tt>
    #
    # @param [Object] value
    #   The value to push onto the back of the queue
    def push(value)
      new_back = QueueNode.new(:value => value)
      
      @back.successor = new_back if @back
      @front = new_back unless @front
      @back = new_back
      
      @size += 1
    end
    
    # Pop the value off the front of the queue.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   The value at the front of the queue
    #
    # @raise [IndexOutOfRange]
    #   When the queue is #empty?
    def pop
      assert_not_empty
          
      value = @front.value
      @front = @front.successor if @front
      @size -= 1
      
      value
    end
    
    # Peek at the value from the top of the stack.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   The value at the front of the queue
    #
    # @raise [IndexOutOfRange]
    #   When the queue is #empty?
    def peek
      assert_not_empty
      
      @front.value
    end
    
    # Determine whether the queue is empty.
    #
    # <tt>O(1)</tt>
    #
    # @return [Object]
    #   <tt>true</tt> if the queue is empty, otherwise <tt>false</tt>
    def empty?
      @size == 0
    end
  
    private

    # Raise IndexOutOfRange when the queue is #empty?.
    #
    # <tt>O(1)</tt>
    #
    # @raise [IndexOutOfRange]
    #   When the queue is #empty?
    def assert_not_empty
      raise IndexOutOfRange if empty?
    end
   
    # Data structure for storing the nodes in the queue.
    # 
    # @private
    class QueueNode
    
      attr_accessor :successor
      attr_reader :value
    
      def initialize(args)
        @value = args[:value]
      end
    
    end
  
  end

end
