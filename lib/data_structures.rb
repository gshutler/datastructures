require File.join(File.dirname(__FILE__), 'linked_list')
require File.join(File.dirname(__FILE__), 'stack')
require File.join(File.dirname(__FILE__), 'queue')

module DataStructures

  # Error raised when a request it made with an index outside the valid range
  # for the data structure
  class IndexOutOfRange < StandardError; end

end
