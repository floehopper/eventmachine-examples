require 'bundler/setup'
require 'eventmachine'

operation = -> do
  puts "operation thread: #{Thread.current.object_id}"
  'result'
end

callback = -> result do
  puts "callback: #{result}"
  EventMachine.stop
end

errback = -> result do
  puts "errback: #{errback}"
  EventMachine.stop
end

puts "main thread: #{Thread.current.object_id}"

EventMachine.run do
  EventMachine.defer(operation, callback, errback)
end
