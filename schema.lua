return {
  no_consumer = true,
  fields = {
    redirect_to = { type = "string", default = "" },
    header = { type = "string", default = "X-Forwarded-Proto" },
    expected_value = { type = "string", default = "https" },
    ignore_uris = { type = "array", default = {} },
    redirect_if_unset = { type = "bool", default = false },
    strip_uri = { type = "bool", default = false },
    redirect_http_code = {type = "array", enum = {"301", "302", "303", "307"}, default = "301"}
  },
  self_check = function(schema, plugin_t, dao, is_update)
    if not plugin_t.redirect_to then
       ngx.log(ngx.NOTICE, "force-elb-https: redirect domain missing")
       return false, "redirect_domain cannot be blank"
    end

    if plugin_t.redirect_to == "" then
       ngx.log(ngx.NOTICE, "force-elb-https: redirect domain blank")
       return false, "redirect_domain cannot be blank"
    end

    if not plugin_t.header then
       ngx.log(ngx.NOTICE, "force-elb-https: header missing")
       return false, "header cannot be blank"
    end

    if plugin_t.header == "" then
       ngx.log(ngx.NOTICE, "force-elb-https: header cannot be blank")
       return false, "header cannot be blank"
    end

    if not plugin_t.expected_value then
       ngx.log(ngx.NOTICE, "force-elb-https: expected_value missing")
       return false, "expected_value cannot be blank"
    end

    if plugin_t.expected_value == "" then
       ngx.log(ngx.NOTICE, "force-elb-https: expected_value cannot be blank")
       return false, "expected_value cannot be blank"
    end

    return true
  end
}

