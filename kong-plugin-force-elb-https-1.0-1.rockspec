package = "kong-plugin-force-elb-https"
version = "1.0-1"
source = {
  url = "TBD"
}
description = {
  summary = "A Kong plugin that will redirect to HTTPS if X-Forwarded-Proto is http. For use with Amazon AWS ELB.",
  license = "MIT"
}
dependencies = {
  "lua ~> 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.force-elb-https.handler"] = "handler.lua",
    ["kong.plugins.force-elb-https.schema"]  = "schema.lua"
  }
}
