local typedefs = require "kong.db.schema.typedefs"

local PLUGIN_NAME = "force-elb-https"

local REDIRECT_CODES = {301, 302, 303, 307}

local schema = {
  name = PLUGIN_NAME,

  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {  
      type = "record",
      fields = {
        { redirect_to = { 
            type = "string", 
            required=true, 
            description = "Where to redirect the user to if match fails." 
          } 
        },
        { header = {
            type="string",
            description = "The header to examine.",
            required=true,
            default = "X-Forwarded-Proto"
          }
        },
        { expected_value = {
            type="string",
            description = "The value to match against the header.",
            required=true,
            default = "https"
          }
        },
        { ignore_uris = {
            type="array",
            description = "A list of URIs to ignore.",
            elements = { type = "string" }
          }
        },
        { redirect_if_unset = {
            type="boolean",
            description = "If the header is not set, should we redirect?",
            default = false
          }
        },
        { strip_uri = {
            type="boolean",
            description = "Should we strip the URI before redirecting?",
            default = false
          }
        },
        { redirect_http_code = {
            type="number",
            description = "The HTTP code to use for the redirect.",
            one_of = REDIRECT_CODES,
            required=true,
            default = 301
          }
        }
      }
    }
   }
  }
}

return schema


