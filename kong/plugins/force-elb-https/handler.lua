local BasePlugin = require "kong.plugins.base_plugin"
local responses = require "kong.tools.responses"
local req_set_header = ngx.req.set_header
local ngx_re_gmatch = ngx.re.gmatch

local ForceHTTPSHandler = BasePlugin:extend()

-- want this to be very low and run first if possible. we run after ip-restriction in the stack
ForceHTTPSHandler.PRIORITY = 2750
ForceHTTPSHandler.VERSION = "0.1"

function ForceHTTPSHandler:new()
  ForceHTTPSHandler.super.new(self, "force-elb-https")
end

function ForceHTTPSHandler:access(conf)
  ForceHTTPSHandler.super.access(self)

  -- should we pass?
  if conf.ignore_uris then 
    for _, v in ipairs(conf.ignore_uris) do
       if string.sub(ngx.var.request_uri, 0, v:len()) == v then
          return false
       end
   end
  end

  local proto_header = ngx.req.get_headers()[conf.header]
  
  -- if we can't find the header, and redirect_if_unset is set,
  -- continue down the path of redirecting to https
  if not proto_header then
     if not conf.redirect_if_unset then
       return false
     end
  else
    -- we have the header, if it matches, we will stop processing
    if proto_header == conf.expected_value then
       return false
    end
  end

  -- we only use redirect domain if the host header is unset
  local host_header = ngx.req.get_headers()["host"]
  local redirect_domain = conf.redirect_to
  
  if host_header then
    redirect_domain = host_header
  end
  
  -- load config
  local https_url = "https://" .. redirect_domain .. ngx.var.request_uri

  if conf.strip_uri then
    https_url = "https://" .. redirect_domain
  end
  
  return ngx.redirect(https_url, conf.redirect_http_code)
end

return ForceHTTPSHandler
