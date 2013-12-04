function find_cells()
	local cells = {}
	local attached = peripheral.getNames()
	for n, dir in pairs(attached) do
		local typ = peripheral.getType(dir)
		if typ == "redstone_energy_cell" then
			table.insert(cells, peripheral.wrap(dir))
		end
	end
	return cells
end

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

local id = os.getComputerID()
local modem = find_modem()
local channel = 7

while true do
	local cells = find_cells()
--	local msg = "cells:"..id
	local total_cap = 0
	local total_load = 0
	local cnt = 0
	for n, cell in pairs(cells) do
		local max = cell.getMaxEnergyStored()
		local cur = cell.getEnergyStored()
		cnt = cnt + 1
		total_cap = total_cap + max
		total_load = total_load + cur
--		msg = msg .. ":" .. cur .. "/" .. max
	end
--	print(msg)
	local msg = "cell:"..id..":"..cnt..":"..total_load..":"..total_cap
	modem.transmit(channel, 0, msg)
	sleep(3)
end



--getActivationEnergy
--getLatency
--getMinEnergyReceived
--getMaxEnergyReceived
--getMaxEnergyStored
--getEnergyStored
--getPowerProvider
--getEnergySend
--getEnergyReceive
