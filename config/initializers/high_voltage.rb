# serve up routes for static pages from the root of the domain path
HighVoltage.configure do |config|
  config.route_drawer = HighVoltage::RouteDrawers::Root
end