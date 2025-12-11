local robotlib = {}

local robots = {nil}
local cmds = {"u", "d", "r", "l", "f"}

rednet.open()

function robotlib.connect(robots1)
    for k, v in pairs(robots1) do
        if tonumber(v) == nil then
            return false
        end
    end

    local answers = {}
    for k, v in pairs(robots1) do
        rednet.send(v, "connect")
        local snr, msg = rednet.receive()
        table.insert(answers, msg)
        if msg == true then
            table.insert(robots, v)
        end
    end
    return answers
end

function robotlib.send(command)
    if robots[1] == nil then
        return false
    end

    local cmd = {}

    for word in string.gmatch(msg, "%S+") do
        table.insert(cmd, word)
    end

    local proverka = false
    for k, v in pairs(cmds) do
        if cmd[1] == v then
            proverka = true
            break
        end
    end
    if not proverka then
        return false
    end

    local answers = {}
    for k, v in pairs(robots) do
        rednet.send(v, command)
    end
    for k, v in pairs(robots) do
        local snr, msg = rednet.receive()
        table.insert(answers, msg)
    end
    return answers
end

function robotlib.disconnect()
    if robots[1] == nil then
        return false
    end

    for k, v in pairs(robots) do
        rednet.send(v, "disconnect")
    end
    robots = {nil}
    return true
end

return robotlib