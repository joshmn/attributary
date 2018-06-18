require 'rubygems'
require 'bundler'
Bundler.setup

require 'rake'
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'attributary'
