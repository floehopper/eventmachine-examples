require 'bundler/setup'
require 'eventmachine'

class MyDeferrable
  include EventMachine::Deferrable

  def call
    puts "deferrable thread: #{Thread.current.object_id}"
    succeed('result')
  end
end

deferrable = MyDeferrable.new

deferrable.callback do |result|
  puts "callback: #{result}"
  EventMachine.stop
end

deferrable.errback do |result|
  puts "errback: #{result}"
  EventMachine.stop
end

puts "main thread: #{Thread.current.object_id}"

EventMachine.run do
  EventMachine.add_timer(0, deferrable)
end
