require 'cinch'
# require 'cinch/plugins/twitter'
require 'redis'
require_relative "lib/eve/plugins/urban_dictionary"
require_relative "lib/eve/plugins/help"
require_relative "lib/eve/plugins/seen"
require_relative "lib/eve/plugins/greeting"
require_relative "lib/eve/plugins/eightball"
require_relative "lib/eve/plugins/decide"
require_relative "lib/eve/plugins/memo"
require_relative "lib/eve/plugins/ai"
require_relative "lib/eve/plugins/control_panel"
require_relative "lib/eve/plugins/chanop_cp"
require_relative "lib/eve/plugins/private_cp"
require_relative "lib/eve/plugins/priv_chan_cp"
require_relative "lib/eve/plugins/fact_core"
require_relative "lib/eve/plugins/act_ai"
require_relative "lib/eve/plugins/url_scraper"
require_relative "lib/eve/plugins/twitter"
require_relative "lib/eve/plugins/twitter_status"
require_relative "lib/eve/plugins/plugin_management"
require_relative "lib/eve/plugins/valentine_boxx"
require_relative "lib/eve/plugins/wikipedia"


# You should have something in the block below as it will have Eve report
# invalid or unauthorized use of her commands to the nicks you place in it
# Note: Please keep in mind that this doesn't check if the dispatch nick 
# is authed so if for some reason it is imperative that no one but the bot
# masters see output maybe it is wise to only put your nick in here and 
# make sure no one steals it!

Config = OpenStruct.new

Config.dispatch = ["foo", "bar", "you"]

# In the block below make sure to enter your server information as well as
# the channels that you want it to join. Don't be lazy!

bot = Cinch::Bot.new do
  configure do |c|
  c.server = "rawr.sinsira.net"
  c.channels = ["#Eve"]
  c.nick = "Eve"
  c.user = "Eve"
  c.realname = "Eve 2.6"
  c.plugins.plugins = [Cinch::Plugins::PluginManagement,
	Cinch::Plugins::UrbanDictionary,
	Cinch::Plugins::Help,
	Cinch::Plugins::Seen,
	Cinch::Plugins::Greeting,
	Cinch::Plugins::Eightball,
	Cinch::Plugins::Decide,
	Cinch::Plugins::Memo,
  Cinch::Plugins::AIRespond,
  Cinch::Plugins::ControlPanel,
  Cinch::Plugins::ChanopCP,
  Cinch::Plugins::PrivateCP,
  Cinch::Plugins::PrivChanCP,
  Cinch::Plugins::FactCore,
  Cinch::Plugins::ActAI,
  Cinch::Plugins::UrlScraper,
  Cinch::Plugins::Twitter,
  Cinch::Plugins::TwitterStatus,
  Cinch::Plugins::Forecast,
  Cinch::Plugins::ValentineBoxx,
  Cinch::Plugins::Wikipedia];
  #c.plugins.options[Cinch::Plugins::UrlScraper] = { enabled_channels: ["#foo", "#bar" "#channel"] }
  #c.plugins.options[Cinch::Plugins::Greeting] = { enabled_channels: ["#foo", "#bar" "#channel"] }
  #c.plugins.options[Cinch::Plugins::TwitterStatus] = {
  #                                                   consumer_key:    'foo',
  #                                                   consumer_secret: 'foo',
  #                                                   oauth_token:     'foo',
  #                                                   oauth_secret:    'foo',
  #                                                   watchers:        { '#foo' => ['bar'] } }
  #c.plugins.options[Cinch::Plugins::Twitter] = { 
  #access_keys: { 
  #  consumer_key: "foo", 
  #  consumer_secret: "foo", 
  #  oauth_token: "foo", 
  #  oauth_token_secret: "foo" 
  #} 
#}
    c.password = "nspass"
  end
end

bot.start