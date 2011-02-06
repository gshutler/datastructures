require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'data_structures')

describe DataStructures::Queue do

  let(:queue) { DataStructures::Queue.new }
  
  describe "an empty queue" do
    
    it "should be empty" do
      queue.should be_empty
    end
    
    it "should have a size of 0" do
      queue.size.should == 0
    end
    
    it "should raise an error when trying to pop" do
      expect { queue.pop }.should raise_error(DataStructures::IndexOutOfRange)
    end
    
  end
  
  describe "pushing an item into the queue" do
  
    before do
      queue.push("a")
    end
    
    it "should have 1 item in the list" do
      queue.size.should == 1
    end
      
    it "should return \"a\" when popping" do
      queue.pop.should == "a"
    end
  
  end
  
  describe "pushing two items" do
    
    before do
      queue.push("a")
      queue.push("b")
    end
    
    it "should have 2 items in the list" do
      queue.size.should == 2
    end
    
    it "should pop the items in the same order" do
      queue.pop.should == "a"
      queue.pop.should == "b"
    end
    
  end
  
  describe "peeking" do
  
    describe "a populated queue" do
    
      before do
        queue.push("a")
        queue.push("b")
      end
      
      let(:peeked_value) { queue.peek }
      
      it "should return the first value pushed into the queue" do
        peeked_value.should == "a"
      end
      
      it "should not alter the state of the queue" do
        queue.size.should == 2
        queue.pop.should == "a"
      end
    
    end
  
    describe "an empty stack" do
    
      it "should raise an error when trying to peek" do
        expect { queue.peek }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
  
  end

end
