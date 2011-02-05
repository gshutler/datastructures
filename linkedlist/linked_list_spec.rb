require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__), 'linked_list')

describe DataStructures::LinkedList do

  let(:list) { DataStructures::LinkedList.new }
  
  describe "an empty list" do
    
    it "should be empty" do
      list.should be_empty
    end
    
    it "should have a size of 0" do
      list.size.should == 0
    end
    
    it "should raise an error when trying to retrieve the first value" do
      expect { list.get(0) }.should raise_error(DataStructures::IndexOutOfRange)
    end
    
  end
  
  describe "appending an item to the list" do
  
    before do
      list.append("a")
    end
    
    it "should have 1 item in the list" do
      list.size.should == 1
    end
      
    it "should return \"a\" as the first item" do
      list.get(0).should == "a"
    end
  
  end
  
  describe "appending two items to the list" do
    
    before do
      list.append("a")
      list.append("b")
    end
    
    it "should have 2 items in the list" do
      list.size.should == 2
    end
    
    it "should return the first appended item first" do
      list.get(0).should == "a"
    end
    
    it "should return the second appended item second" do
      list.get(1).should == "b"
    end
    
  end
  
  describe "iterating over a list" do
    
    before do
      list.append("a")
      list.append("b")
      list.append("c")
    end
    
    let(:concatonated_values) do
      concat = ""
      list.each {|v| concat += v}      
      concat
    end
    
    it "should yield the values in order" do
      concatonated_values.should == "abc"
    end
  
  end
  
  describe "reversing a list" do
  
    before do
      list.append("a")
      list.append("b")
      list.append("c")
    end
   
    let(:reversed_list) { list.reverse }
   
    let(:concatonated_values) do
      concat = ""
      reversed_list.each {|v| concat += v}      
      concat
    end
    
    it "should yield the values in reverse order" do
      concatonated_values.should == "cba"
    end
  
  end
  
  describe "iterating a list in reverse" do
  
    before do
      list.append("a")
      list.append("b")
      list.append("c")
    end
    
    let(:concatonated_values) do
      concat = ""
      list.each_reverse {|v| concat += v}      
      concat
    end
    
    it "should yield the values in reverse order" do
      concatonated_values.should == "cba"
    end
  
  end
  
  describe "inserting an item" do
  
    before do
      list.append("a")
      list.append("b")
    end
    
    describe "in the middle" do
    
      before do    
        list.insert(1, "X")
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
    
      it "should insert the item at the specified index" do
        concatonated_values.should == "aXb"
      end
    
    end
    
    describe "at the beginning" do
    
      before do    
        list.insert(0, "X")
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
    
      it "should insert the item at the specified index" do
        concatonated_values.should == "Xab"
      end
    
    end
    
    describe "at the end" do
    
      before do    
        list.insert(2, "X")
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
    
      it "should insert the item at the specified index" do
        concatonated_values.should == "abX"
      end
    
    end
    
    describe "at a negative index" do
    
      it "should raise an index out of range error" do
        expect { list.insert(-1, nil) }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
    
    describe "more than one beyond the last item" do
    
      let(:beyond_end) { list.size + 1 }
    
      it "should raise an index out of range error" do
        expect { list.insert(beyond_end, nil) }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
  
  end
  
  describe "removing an item" do
  
    before do
      list.append("a")
      list.append("b")
      list.append("c")
    end    
  
    describe "from the middle" do
  
      before do
        list.remove(1)
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
          
      it "should remove the item at the specified index" do
        concatonated_values.should == "ac"
      end
      
    end
    
    describe "from the end" do
  
      before do
        list.remove(2)
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
          
      it "should remove the item at the specified index" do
        concatonated_values.should == "ab"
      end
      
    end
    
    describe "from the beginning" do
  
      before do
        list.remove(0)
      end
      
      let(:concatonated_values) do
        concat = ""
        list.each {|v| concat += v}      
        concat
      end
      
      it "should remove the item at the specified index" do
        concatonated_values.should == "bc"
      end
      
    end
    
    describe "at a negative index" do
    
      it "should raise an index out of range error" do
        expect { list.remove(-1) }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
    
    describe "at an index after the last item" do
    
      it "should raise an index out of range error" do
        expect { list.remove(list.size) }.should raise_error(DataStructures::IndexOutOfRange)
      end
    
    end
  
  end

end
