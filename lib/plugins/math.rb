require 'calc'
require 'cinch'
require_relative "config/check_ignore"

module Cinch
  module Plugins
    class Math
      include Cinch::Plugin
      
      set :plugin_name, 'math'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
Is it just you, or is your favorite website down? Find out!
Usage:
* !calc <problem>: Returns the sum of the given problem.
USAGE
    
      match /calc (.+)/
    
      def execute(m, math)
        return if check_ignore(m.user)
        m.reply calculate(math), true
      end
    
      def calculate(math)
        sum = Calc.evaluate(math)
        return "#{Calc.evaluate(math)}" unless sum == math
      rescue ZeroDivisionError
        return "Did you break the world?"
      end
    end
  end
end