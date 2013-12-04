function find_modem()
	local attached = peripheral.getNames()
	for n, dir in pairs(attached) do
		local typ = peripheral.getType(dir)
		if typ == "modem" then
			return peripheral.wrap(dir)
		end
	end
	return nil
end

local modem = find_modem()
local channel = 7
local monitor = peripheral.wrap("left")
modem.open()
while true do
	local event, modemSide, senderChannel, replyChannel,
		message, senderDistance = os.pullEvent("modem_message")
	local f = string.gmatch(messge, "[^:]+")
	local name = f()
	local id = f()
	local n = f()
	local cur = f()
	local cap = f()
	local pro = (cur/cap)*100
	local m = id..": "..pro.."% "..cur.."/"..cap
	print(m)
	monitor.clear()
	monitor.setCursorPos(1, 1)
	monitor.write(m)
end

