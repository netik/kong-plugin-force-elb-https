
# kong-plugin-force-elb-https

## What it does

This plugin redirects clients connecting to your site to the HTTPS
version of your site examining a configurable request header. Unless
the header matches an expected value, a redirect will be issued. 
It defaults to examining the `X-Forwarded-Proto` header,
looking for the string "https".

## Why?

Many sites use Amazon AWS and ELB (Elastic Load Balancing) to route
and process traffic. When the ELB is terminating SSL and forwarding
traffic to your EC2 hosts via HTTP, the only way to tell if the
original request was made over HTTPS is to verify the header.

Amazon's ELB (Elastic Load Balancer) sets the X-Forwarded-Proto header
when forwarding requests from external clients.

Rather than modifying Kong's Nginx configuration via templates, you
can use this plugin to provide this functionality. I find that it's
much easier and far more transparent / flexible to handle this at the
plugin layer.

## How it works

The plugin examines the desired header set in the plugin's
configuration. If it is set to the `expected_value` in the
configuration, nothing happens.

If the header doesn't exist and the configure variable
redirect_if_unset is set to true, it will redirect to https
always. Note that if your edge load balancer fails to set the
X-Forwarded-Proto header at this point, it will create an infinite
redirect loop!

You can optionally add `strip_uri`, which upon the initial redirect
will strip off the URI. The default behavior is to redirect to
`https://<HOST HEADER>/URI` when the plugin redirects.

`ignore_uris` will disable this plugin for any uri that starts with
the desired paths. Remember to start paths with `/` !

## Rebuilding

If you need to rebuild this plugin install luarocks, and do:

`luarocks make`


## Configuration

form parameter|required|description
---|---|---
`name`|*required*|The name of the plugin to use, in this case: `force-elb-https`
`redirect_to`|*required*|The domain name to redirect the user to if the host header is unset
`ignore_uris`|*optional*|Anything starting with these paths is ignored by the plugin. (default: none)
`redirect_if_unset`|*optional*|If the `X-Forwarded-Proto` header is absent, force redirection to HTTPS. (default: false)
`strip_uri`|*optional*|During redirection, strip off the URI from the URL. (default: false)
`redirect_http_code`|*optional*|Which HTTP code to send when redirecting. One of 301, 302, 303, or 307 (default: 301)
