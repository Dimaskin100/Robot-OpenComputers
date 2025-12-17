local robotlib = {}

local robots = {}
local cmds = {
    f = true, b = true, l = true, r = true, u = true, d = true,
    a = true, au = true, ad = true,
    dg = true, dgu = true, dgd = true,
    sel = true, tt = true
}

rednet.open("right")

function robotlib.connect(robots1)
    for k, v in pairs(robots1) do
        if tonumber(v) == nil then
            return false
        end
    end

    local answers = {}
    for k, v in pairs(robots1) do
        rednet.send(v, "connect")
        local snr, msg = rednet.receive(2)
        if snr and snr == v then
            table.insert(answers, {id = snr, msg = msg, dte = dte})
            if msg == true then
                table.insert(robots, snr)
            end
        else
            table.insert(answers, {id = v, msg = false})
        end
    end
    
    return answers
end

function robotlib.send(command)
    if #robots == 0 then
        return false
    end

    local cmd = {}
    for word in string.gmatch(command, "%S+") do
        table.insert(cmd, word)
    end

    if not cmds[cmd[1]] then
        return false
    end

    local answers = {}
    for k, v in pairs(robots) do
        rednet.send(v, command)
        local snr, msg = rednet.receive(2)
        if snr and snr == v then
            table.insert(answers, {id = snr, msg = msg, dte = dte})
        else
            table.insert(answers, {id = v, msg = false})
        end
    end
    
    return answers
end

function robotlib.searchRobot(robots1)
    local answers = {}
    
end

function robotlib.isHaveControl(robots1)
local answers = {}
    
for k, v in pairs(robots1) do
rednet.send(v, "isHaveControl")
        local snr, msg, dte = rednet.receive(0.3)

        if snr == v then
table.insert(answers, {id = snr, msg =  msg, dte = dte})
        else
            table.insert(answers, {id = v, msg = false})
        end
    end

    return answers
end

function robotlib.disconnect()
    if #robots == 0 then
        return false
    end

    for k, v in pairs(robots) do
        rednet.send(v, "disconnect")
    end
    robots = {}
    return true
end

return robotlib



