print("launch")

local r = require("robotlib")
local dlina = nil
local time = nil
local id = nil

term.clear()

print("Write id robot: ")
id = tonumber(io.read())

r.connect({id})

term.clear()

print("Write dlina: ")
dlina = tonumber(io.read())

term.clear()

print("Write time")
time = tonumber(io.read())

term.clear()

while true do
r.send("u")

for i = 1, dlina do
r.send("f")
  r.send("dgd")
  r.send("pd")
end

r.send("r") r.send("r")

for i = 1, dlina do
r.send("f")
end

r.send("r") r.send("r") r.send("d")

sleep(time)
end
