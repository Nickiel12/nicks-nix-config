local p = require 'dbus_proxy'

local dbus = {}

dbus.proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.awesome.galaxymenu",
    interface = "org.awsome.galaxymenu",
    path = "/org/awsome/galaxymenu/Main"
  }
)


dbus.callback = function () {
    
}
