-- wget -f https://pastebin.com/raw/UWGeEjHa r
 
print("Запуск")
 
local Version = 6
local errors = 0
local comp = require("computer")
local c = require("component")
if not c.isAvailable("robot") then
    term.clear()
    print("Эта программа для робота")
    comp.beep()
    comp.beep()
    errors = errors + 1
    end
if not c.isAvailable("modem") then
    if errors == 0 then
        term.clear()
        end
    print("Не подключен модем")
    comp.beep()
    comp.beep()
    errors = errors + 1
    end
if not c.isAvailable("chunkloader") then
    if errors == 0 then
        term.clear()
        end
    print("Не подключен загрузчик чанков")
    comp.beep()
    comp.beep()
    errors = errors + 1
    end
if errors >= 1 then
    os.exit()
    end
 
local r = require("robot")
local modem = c.modem
local cl = c.chunkloader
local term = require("term")
local m1 = 0
 
local function start1()
    modem.open(m1)
    while true do
        local event,_,_,_,_,message = comp.pullSignal()
        if event == "modem_message" then
        if message == "stop" then
               modem.close(m1)
                cl.setActive(false)
                comp.shutdown(false)
                end
        if message == "proverka" then
        modem.close(m1)
        os.sleep(1)
        modem.broadcast(m1, "robot")
        start1()
        end
        if message == "Version" then
        modem.close(m1)
        os.sleep(1)
        modem.broadcast(m1, Version)
        start1()
        end
        if message == "r" then
                comp.beep()
            r.turnRight()
        elseif message == "l" then
                comp.beep()
            r.turnLeft()
        elseif message == "u" then
            comp.beep()
            if r.detectUp() == true then
            r.swingUp()
                end
            r.up()
        elseif message == "d" then
                comp.beep()
            if r.detectDown() == true then
            r.swingDown()
            end
            r.down()
        elseif message == "f" then
                comp.beep()
            if r.detect() == true then
            r.swing()
                end
            r.forward()
        elseif message == "raz" then
                comp.beep()
            r.turnAround()
                elseif message == "p" then
                comp.beep()
            r.place()
                elseif message == "pu" then
                comp.beep()
            r.placeUp()
                elseif message == "pd" then
                comp.beep()
            r.placeDown()
                elseif message == "s" then
                comp.beep()
            r.swing()
                elseif message == "su" then
                comp.beep()
            r.swingUp()
                elseif message == "sd" then
                comp.beep()
            r.swingDown()
                elseif message == "dr" then
                comp.beep()
            r.drop()
                elseif message == "dru" then
                comp.beep()
            r.dropUp()
                elseif message == "drd" then
                comp.beep()
            r.dropDown()
                elseif message == "suck" then
                comp.beep()
                r.suck()
                elseif message == "use" then
                comp.beep()
                r.use()
                elseif message == "usd" then
                comp.beep()
                r.useDown()
                elseif message == "usu" then
                comp.beep()
                r.useUp()
                elseif message == "sel" then
                comp.beep()
             local event,_,_,_,_,message = comp.pullSignal()
            if event == "modem_message" then
                    r.select(tonumber(message))
                    comp.beep()
                    start1()
                    end
                elseif message == "tt" then
                comp.beep()
             local event,_,_,_,_,message = comp.pullSignal()
                if event == "modem_message" then
                    r.transferTo(tonumber(message))
                    comp.beep()
                    start1()
                    end
            else
            d = tonumber(message)
            modem.close(m1)
            os.sleep(0.2)
            modem.open(m1)
             local event,_,_,_,_,message2 = comp.pullSignal()
            if event == "modem_message" then
            v = tonumber(message2)
            modem.close(m1)
            local function start()
    comp.beep()
    for i = 1, v do
if r.detectDown() == true then
r.swingDown()
else
r.down()
modem.broadcast(m1, i.." Вниз")
end
end
 
for i = 1, d do
if r.detect() == true then
r.swing()
else
r.forward()
modem.broadcast(m1, i.." Вперёд")
if r.detectUp() == true then
r.swingUp()
end
end
end
 
r.turnAround()
 
for i = 1, d do
if r.detect() == true then
r.swing()
else
r.forward()
modem.broadcast(m1, i.." Назад")
if r.detectUp() == true then
r.swingUp()
end
end
end
 
r.turnAround()
 
for i = 1, v do
if r.detectUp() == true then
r.swingUp()
else
r.up()
modem.broadcast(m1, i.." Наверх")
end
end
   
os.sleep(1)
 
    d = 0
    v = 0
    comp.beep()
    modem.broadcast(m1, "end")
    start1()
    end
            start()
                end
                end
            end
    end
    end
 
    os.sleep(2)
    term.clear()
 
    local function Port()
io.write("Порт: ")
err, try = pcall(io.read)
m1 = tonumber(try)

if m1 == nil then
Port()
end
 
    term.clear()
    cl.setActive(true)
    start1()
    end
    
    Port()