local r = require("robotlib")

term.clear()

print("Write ID robots")
local a = io.read()

local con = {}

for word in string.gmatch(a, "%S+") do
table.insert(con, word)
end
for i = 1, #con do
con[i] = tonumber(con[i])
end

local answer = r.connect(con)

term.clear()

for k, v in pairs(answer) do
if v == false then
r.disconnect()
print("connect failed")
sleep(2) os.reboot()
end
end

local d = io.read("Dlina: ")
local v = io.read("Visota: ")

for i = 1, v do
r.send("dgd") r.send("d")
end

for i = 1, d do
r.send("dg") r.send("f")
end

r.send("r") r.send("r")

for i = 1, d do
r.send("dg") r.send("f")
end

for i = 1, v do
r.send("dgu") r.send("u")
end


r.disconnect()
