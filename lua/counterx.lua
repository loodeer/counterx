--
-- Created by IntelliJ IDEA.
-- User: loodeer
-- Date: 2019-05-05
-- Time: 00:50
-- To change this template use File | Settings | File Templates.
--
local function close_redis(red)
    if not red then
        return
    end
    -- 连接池实现释放连接
    local pool_max_idle_time = 10000 -- 毫秒
    local pool_size = 100 -- 连接池大小
    local ok,err = red:set_keepalive(pool_max_idle_time, pool_size)
    if not ok then
        ngx.say("set keepalive error:", err)
    end
end

local redis = require("resty.redis")

-- 创建实例
local red = redis:new()
-- 设置超时 单位毫秒
red:set_timeout(1000)
-- 建立连接
local ip = "127.0.0.1"
local port = 6379
local ok,err = red:connect(ip, port)
if not ok then
    ngx.say("connect to redis error:", err)
    return close_redis(red)
end

local key = "uid_badge_" .. ngx.var.uid
local resp,err = red:get(key)
if not resp then
    ngx.say("get badge err:", err)
    return close_redis(red)
end

if resp == ngx.null then
    resp = "counterx 未初始化"
end

ngx.say(resp)
-- output:
--{
--    "unread_count": "4",
--    "unread_dot": "0",
--    "cart": "11",
--    "message_cnt": "13",
--    "activity_message_count": "2"
--}

close_redis(red)
