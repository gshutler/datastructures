require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'data_structures')

describe DataStructures::Stack do

  let(:stack) { DataStructures::Stack.new }
  
  describe "an empty stack" do
    
    it "should be empty" do
      stack.should be_empty
    end
    
    it "should have a size of 0" do
      stack.size.should == 0
    end
    
    it "should raise an error when trying to pop" do
      expect { stack.pop }.should raise_error(DataStructures::IndexOutOfRange)
    end
    
  end
  
  describe "pushing an item onto the stack" do
  
    before do
      stack.push("a")
    end
    
    it "should have 1 item in the list" do
      stack.size.should == 1
    end
      
    it "should return \"a\" when popping" do
      stack.pop.should == "a"
    end
  
  end
  
  describe "pushing two items" do
    
    before do
      stack.push("a")
      stack.push("b")
    end
    
    it "should have 2 items in the list" do
      stack.size.should == 2
    end
    
    it "should pop the items in reverse" do
      stack.pop.should == "b"
      stack.pop.should == "a"
    end
    
  end
  
  describe "peeking" do
  
    describe "a populated stack" do
    
      before do
        stack.push("a")
      end
      
      let(:peeked_value) { stack.peek }
      
      it "should return the value at the top of the stack" do
        peeked_value.should == "a"
      end
      
      it "should not alter the state of the stack" do
        stack.size.should == 1
        stack.pop.should == "a"
      end
    
    end
  
    describe "an empty stack" do
    
      it "should raise an error when trying to peek" do
        expect { stack.peek }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
  
  end

end
