-- wget -f https://raw.githubusercontent.com/Dimaskin100/Robot-OpenComputers/refs/heads/main/RT.lua r
 
print("Запуск")

local Version = 6
local errors = 0
local c = require("component")
local comp = require("computer")
local term = require("term")
local comp = require("computer")
local m1 = 0
 
if not c.isAvailable("modem") then
        term.clear()
    print("Не подключен модем")
    comp.beep()
    comp.beep()
    errors = errors + 1
    end
if errors >= 1 then
    os.exit()
    end
 
local modem = c.modem
 
local function menu()
term.clear()
print("s - p - end - stop")
io.write("")
err, try = pcall(io.read)
if try == "s" then
    menu()
    elseif try == "p" then
    local function start1()
    term.clear()
    print("r - повернуть направо, l - повернуть налево")
    print("u - вверх, d - вниз")
    print("f - прямо, raz - развернуть")
    print("p - поставить, pu - поставить сверху, pd - поставить снизу")
    print("s - сломать, su - сломать сверху, sd - сломать снизу")
    print("dr - выкинуть, dru - выкинуть сверху, drd - выкинуть снизу")
    print("suck - взять предмет, use - правая кнопка мыши, usd, usu")
    print("sel - выбрать слот, tt - переместить в слот")
    print("end - выйти")
    print("")
    io.write("")
err4, try4 = pcall(io.read)
    if try4 == "r" then
    modem.broadcast(m1, "r")
    elseif try4 == "l" then
    modem.broadcast(m1, "l")
    elseif try4 == "u" then
    modem.broadcast(m1, "u")
    elseif try4 == "d" then
    modem.broadcast(m1, "d")
    elseif try4 == "f" then
    modem.broadcast(m1, "f")
    elseif try4 == "raz" then
    modem.broadcast(m1, "raz")  
    elseif try4 == "p" then
    modem.broadcast(m1, "p")
    elseif try4 == "pu" then
    modem.broadcast(m1, "pu")
    elseif try4 == "pd" then
    modem.broadcast(m1, "pd")
    elseif try4 == "s" then
    modem.broadcast(m1, "s")
    elseif try4 == "su" then
    modem.broadcast(m1, "su")
    elseif try4 == "sd" then
    modem.broadcast(m1, "sd")
    elseif try4 == "dr" then
    modem.broadcast(m1, "dr")
    elseif try4 == "dru" then
    modem.broadcast(m1, "dru")
    elseif try4 == "drd" then
    modem.broadcast(m1, "drd")
    elseif try4 == "suck" then
    modem.broadcast(m1, "suck")
    elseif try4 == "use" then
    modem.broadcast(m1, "use")
    elseif try4 == "usd" then
    modem.broadcast(m1, "usd")
    elseif try4 == "usu" then
    modem.broadcast(m1, "usu")
    elseif try4 == "sel" then
    term.clear()
    print("Число слота")
    io.write("")
    err, try = pcall(io.read)
    modem.broadcast(m1, "sel")
    os.sleep(0.2)
    modem.broadcast(m1, try)
    elseif try4 == "tt" then
    term.clear()
    print("Число слота")
    io.write("")
    err, try = pcall(io.read)
    modem.broadcast(m1, "tt")
    os.sleep(0.2)
    modem.broadcast(m1, try)
    elseif try4 == "end" then
    menu()
    end
    term.clear()
    start1()
    end
    start1()
        elseif try == "stop" then
        term.clear()
        modem.broadcast(m1, "stop")
        os.exit()
    elseif try == "end" then
    term.clear()
    os.exit()
    else
    menu()
    end
    end
   
os.sleep(2)
 
local function Port()
term.clear()
print("Порт робота")
io.write("")
err3, try3 = pcall(io.read)
m1 = tonumber(try3)
    if m1 == nil then
        Port()
        end
    local function proverka()
term.clear()
print("Поиск робота с портом: "..m1)
modem.broadcast(m1, "proverka")
modem.open(m1)
os.sleep(1)
print("")
print("Робот не найден")
print("Нажмите Enter")
local event,_,_,_,_,message = comp.pullSignal()
    if event == "modem_message" then
    if message == "robot" then
    term.clear()
    print("Поиск робота с портом: "..m1)
    print("")
    print("Робот найден")
    os.sleep(1)
    modem.broadcast(m1, "Version")
    modem.open(m1)
    local event,_,_,_,_,message = comp.pullSignal()
    if event == "modem_message" then
    if tonumber(message) == Version then
    modem.close(m1)
    os.sleep(1)
    menu()               
    else
    term.clear()
    modem.close(m1)
    print("Версия этой программы не совместима с программой робота")
    print("")
    print("Версия программы: "..Version)
    print("Версия программы робота: "..message)
    print("")
    print("Нажмите Enter")
    io.write("") 
err, try = pcall(io.read)
    end
    end
    end
    end
term.clear()
print("Что сделать?")
print("1 - Просканировать снова")
print("2 - Выйти")
print("3 - Поменять порт просканировать снова")
 
io.write("") 
err5, try5 = pcall(io.read)
if try5 == "1" then
    proverka()
    elseif try5 == "2" then
    term.clear()
    os.exit()
    elseif try5 == "3" then
    Port()
    else
    term.clear()
    os.exit()
    end
    end
    proverka()
    end
 

Port()
