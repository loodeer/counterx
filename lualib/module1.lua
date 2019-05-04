--
-- Created by IntelliJ IDEA.
-- User: loodeer
-- Date: 2019-05-05
-- Time: 00:14
-- To change this template use File | Settings | File Templates.
--

local count = 0
local function hello()
    count = count + 1
    ngx.say("count:", count)
end

local _M = {
    hello = hello
}

return _M
