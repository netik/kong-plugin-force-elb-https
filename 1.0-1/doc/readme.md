
# kong-plugin-force-elb-https
## Configuration

This plugin will examine the `X-Forwarded-Proto` header and if it does not exist
or if it is set to `http` it will 301 redirect the user to `https`. Useful
when working with Amazon ELB to redirect users to HTTPS sites.

# form parameters
form parameter|required|description
---|---|---
`name`|*required*|The name of the plugin to use, in this case: `jwt-claims-headers`
`redirect_to`|*required*|The URL to redirect to.
`redirect_if_unset`|*required*|if X-Forwarded-Proto is unset, redirect to https
`ignore_uris`|*optional*|If the URI matches, don't redirect (for health checks, etc.)
