require 'test/unit'
require 'shoulda'
require 'mocha'
require 'ruby-debug'
require 'mongo_mapper'
MongoMapper.database = 'bipolar-test'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'bipolar'
