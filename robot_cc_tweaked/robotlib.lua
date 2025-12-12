local robotlib = {}

local robots = {nil}
local cmds = {
    "f", "b", "l", "r", "u", "d",
    "a", "au", "ad", 
    "dg", "dgu", "dgd", 
    "sel", "tt"
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

        while true do
        local snr, msg = rednet.receive()
        if snr == v then
                table.insert(answers, snr)
        table.insert(answers, msg)

                if msg == true then
                    table.insert(robots, snr)
                end
                
            break
        end
        end
    end
    
    return answers
end

function robotlib.send(command)
    if robots[1] == nil then
        return false
    end

    local cmd = {}

    for word in string.gmatch(command, "%S+") do
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

        while true do
        local snr, msg = rednet.receive()
        if snr == v then
                table.insert(answers, snr)
        table.insert(answers, msg)
            break
        end
        end
    end
    
    return answers
end

function robotlib.searchRobots(number)
    local answers = {}
    
for i = 0, number do
rednet.send(i, "searchRobots")

        while true do
local snr, msg = rednet.receive(0.3)
        
        if not snr == nil then
                if snr == i then
if msg == "robot" then
table.insert(answers, snr)
            end
                    break
        end
            end  
    end
    end

    if answers[1] == nil then return false end

    return answers
end

function robotlib.isHaveControl(ID)
rednet.send(ID, "isHaveControl")

    while true do
local snr, msg = rednet.receive()
        
if snr == ID then
return msg
            break
        end
    end
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







