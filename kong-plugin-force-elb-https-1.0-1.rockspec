package = "kong-plugin-force-elb-https"
version = "1.0-1"

local pluginName = package:match("^kong%-plugin%-(.+)$")  -- "force-elb-https"
supported_platforms = {"linux", "macosx"}

source = {
   url = "git://github.com/netik/kong-plugin-force-elb-https",
   tag = "v1.0",
}

dependencies = {
}

description = {
  summary = "A Kong plugin that will redirect to HTTPS if X-Forwarded-Proto is http. For use with Amazon AWS ELB.",
  license = "MIT"
}
build = {
  type = "builtin",
  modules = {
    -- TODO: add any additional files that the plugin consists of
    ["kong.plugins."..pluginName..".handler"] = "kong/plugins/"..pluginName.."/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "kong/plugins/"..pluginName.."/schema.lua",
  }
}
