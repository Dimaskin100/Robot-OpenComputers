term.clear()
local ctl = nil

rednet.open("right")

while true do

    local snr, msg = rednet.receive()
    local cmd = {}

    for word in string.gmatch(msg, "%S+") do
        table.insert(cmd, word)
    end

    sleep(0.2)

    if ctl == nil then

        if cmd[1] == "connect" then
            if ctl == nil then
                ctl = snr
                rednet.send(snr, true)
            else
                rednet.send(snr, false)
            end
        elseif cmd[1] == "search_robots" then
            rednet.send(snr, "robot")
        end
    else
        
        if snr == ctl then
            
            if cmd[1] == "disconnect" then
                ctl = nil
                rednet.send(snr, true)
            else
                
                local answer = nil

                if cmd[1] == "f" then
                    answer = turtle.forward()
                elseif cmd[1] == "b" then
                    answer = turtle.back()
                elseif cmd[1] == "l" then
                    answer = turtle.turnLeft()
                elseif cmd[1] == "r" then
                    answer = turtle.turnRight()
                elseif cmd[1] == "u" then
                    answer = turtle.up()
                elseif cmd[1] == "d" then
                    answer = turtle.down()
                else
                    answer = false
                end

                rednet.send(ctl, answer)
            end
        else
            
            rednet.send(snr, false)
        end
    end
end

