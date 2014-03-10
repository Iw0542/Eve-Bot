require 'cinch'
require_relative "config/check_master"

module Cinch::Plugins
  class PrivateCP
    include Cinch::Plugin
    include Cinch::Helpers
    set :react_on, :private
    
    set :plugin_name, 'privatecp'
    set :help, <<-USAGE.gsub(/^ {6}/, '')
      Private commands to allow you to control the basic functions of the bot.
      Usage:
      - !say <channel> <message>: This is to be used in a PM with the bot, it will force the bot to say a message in the given channel.
      - !act <channel> <action>: This is to be used in a PM with the bot, it will force the bot to say an action in the given cahnnel.
      - !ns <command>: This will force the bot to send a command to NickServ.
      - !cs <command>: This will force the bot to send a command to ChanServ
      USAGE
      
# This command will cause Eve to send a message to the 
# channel that you ask her to. Please bear in mind that
# there is no announcement other than in the console 
# that someone is making Eve say these things so please
# use caution when adding users to check_master!

    def initialize(*args)
      super
        if File.exist?('docs/userinfo.yaml')
          @storage = YAML.load_file('docs/userinfo.yaml')
        else
          @storage = {}
        end
      end
	  
    match /say (#.+?) (.+)/
	  
  def execute(m, receiver, message)
    reload
    unless check_master(m.user)
      m.reply Format(:red, "You are not authorized to use this command! This incident will be reported!")
      bot.info("Received invalid say command from #{m.user.nick}")
      Config.dispatch.each { |n| User(n).notice("#{m.user.nick} attempted to use the 'say' command but was not authorized.") }
    return;
  end
      Channel(receiver).send(message)
      bot.info("Received valid say command from #{m.user.nick}")
    end
    
# The following command acts the same as the one above
# however it sends the equivalent of /me to the channel
# instead of a message.
    
    match /act (.+?) (.+)/, method: :execute_act
  
  def execute_act(m, receiver, act)
    reload
    unless check_master(m.user)
      m.reply Format(:red, "You are not authorized to use this command! This incident will be reported!")
      bot.info("Received invalid act command from #{m.user.nick}")
      Config.dispatch.each { |n| User(n).notice("#{m.user.nick} attempted to use the 'act' but was not authorized.") }
    return;
  end
      Channel(receiver).action(act)
      bot.info("Received valid act command from #{m.user.nick}")
    end
    
# The following command has Eve send a specified message
# to NickServ. This command can be used just like /ns 
# can be used on your client, so there are a vast array
# of things that can be done with this command!
    
    match /ns (.+?) (.+)/, method: :execute_ns
    
  def execute_ns(m, text)
    reload
    unless check_master(m.user)
      m.reply Format(:red, "You are not authorized to use this command! This incident will be reported!")
      bot.info("Received invalid ns command from #{m.user.nick}")
      Config.dispatch.each { |n| User(n).notice("#{m.user.nick} attempted to use the 'ns' command but was not authorized.") }
    return;
  end
      User("nickserv").send(text)
      bot.info("Received valid ns command from #{m.user.nick}")
    end
    
# The following command does the same as the one above,
# however it allows you to use ChanServ instead!
    
    match /cs (.+?) (.+)/, method: :execute_cs
    
  def execute_cs(m, text)
    reload
    unless check_master(m.user)
      m.reply Format(:red, "You are not authorized to use this command! This incident will be reported")
      bot.info("Received invalid cs command from #{m.user.nick}")
      Config.dispatch.each { |n| User(n).notice("#{m.user.nick} attempted to use the 'cs' command but was not authorized.") }
    return;
  end
      User("chanserv").send(text)
      bot.info("Received valid cs command from #{m.user.nick}")
    end
    
    match /nick (.+)/, method: :execute_nick
    
  def execute_nick(m, nick)
    reload
    unless check_master(m.user)
      m.reply Format(:red, "You are not authorized to use this command! This incident will be reported.")
      bot.info("Received invalid nick command from #{m.user.nick}")
      Config.dispatch.each { |n| User(n).notice("#{m.user.nick} attempted to use the 'nick' command but was not authorized.") }
    return;
  end
    @bot.nick = nick
  end

    def reload
      if File.exist?('docs/userinfo.yaml')
        @storage = YAML.load_file('docs/userinfo.yaml')
      else
        @storage = {}
    end
  end
end
end