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
            table.insert(answers, {id = snr, message = msg})
            if msg == true then
                table.insert(robots, snr)
            end
        else
            return false
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
            table.insert(answers, {id = snr, message = msg})
        else
            return false
        end
    end
    
    return answers
end

function robotlib.searchRobots(number)
    local answers = {}
    
    for i = 0, number do
        rednet.send(i, "searchRobots")
        local snr, msg = rednet.receive(0.3)
        
        if snr and snr == i and msg == "robot" then
            table.insert(answers, snr)
        end
    end

    if #answers == 0 then return false end
    return answers
end

function robotlib.isHaveControl(ID)
    rednet.send(ID, "isHaveControl")
    local snr, msg = rednet.receive(2)
    if snr == ID then
        return msg
    else
        return false
    end
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

