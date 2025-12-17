term.clear()
print("ID: "..os.computerID())

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
            
        elseif cmd[1] == "searchRobot" then
            rednet.send(snr, "robot")

        elseif cmd[1] == "isHaveControl" then
            if ctl == nil then
                rednet.send(snr, false)
            else
                rednet.send(snr, true)
            end
            
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

                elseif cmd[1] == "a" then
                    answer = turtle.attack()

                elseif cmd[1] == "au" then
                    answer = turtle.attackUp()

                elseif cmd[1] == "ad" then
                    answer = turtle.attackDown()

                elseif cmd[1] == "dg" then
                    answer = turtle.dig()

                elseif cmd[1] == "dgu" then
                    answer = turtle.digUp()

                elseif cmd[1] == "dgd" then
                    answer = turtle.digDown()

                elseif cmd[1] == "p" then
                    answer = turtle.place()

                elseif cmd[1] == "pu" then
                    answer = turtle.placeUp()

                elseif cmd[1] == "pd" then
                    answer = turtle.placeDown()

                elseif cmd[1] == "sk" then
                    answer = turtle.suck()

                elseif cmd[1] == "sku" then
                    answer = turtle.suckUp()

                elseif cmd[1] == "skd" then
                    answer = turtle.suckDown()

                elseif cmd[1] == "er" then
                    answer = turtle.equipRight()

                elseif cmd[1] == "el" then
                    answer = turtle.equipLeft()

                elseif cmd[1] == "dr" then
                    answer = turtle.drop()

                elseif cmd[1] == "dru" then
                    answer = turtle.dropUp()

                elseif cmd[1] == "drd" then
                    answer = turtle.dropDown()

                elseif cmd[1] == "dt" then
                    answer = turtle.detect()

                elseif cmd[1] == "dtu" then
                    answer = turtle.detectUp()

                elseif cmd[1] == "dtd" then
                    answer = turtle.detectDown()

                elseif cmd[1] == "sel" then
                    answer = turtle.select(tonumber(cmd[2]))

                elseif cmd[1] == "tt" then
                    answer = turtle.transferTo(tonumber(cmd[2]))

                elseif cmd[1] == "rfl" then
                    answer = turtle.refuel(tonumber(cmd[2]))
                    
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



