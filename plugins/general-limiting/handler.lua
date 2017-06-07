local cache = require "kong.tools.database_cache"
local responses = require "kong.tools.responses"
local BasePlugin = require "kong.plugins.base_plugin"

local GeneralLimitingHandler = BasePlugin:extend()

GeneralLimitingHandler.PRIORITY = 1100

function GeneralLimitingHandler:new(conf)
  GeneralLimitingHandler.super.new(self, "general-limiting")
  cache.sh_add("general_request_counter", 0, 31536000)
end

function GeneralLimitingHandler:access(conf)
  GeneralLimitingHandler.super.access(self)
  local _, err = cache.sh_incr("general_request_counter", 1)
  if err then
    ngx_log("[ganeral-limiting] could not increment counter: "..tostring(err))
    return nil, err
  end
  local current = cache.sh_get("general_request_counter")
  if current > conf.count then
    return responses.send(429, "API rate limit exceeded") 
  end
end

return GeneralLimitingHandler
