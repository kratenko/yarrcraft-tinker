function find_cells()
	local cells = {}
	local attached = peripherals.getNames()
	for n, dir in attached do
		local typ = peripheral.getType(dir)
		if typ == "redstone_energy_cell" then
			tables.insert(cells, peripheral.wrap(dir))
		end
	end
	return cells

function find_modem()
	local attached = peripherals.getNames()
	for n, dir in attached do
		local typ = peripheral.getType(dir)
		if typ == "modem" then
			return peripheral.wrap(dir)
		end
	end
	return nil

local id = os.getComputerID()
local modem = find_modem()
local channel = 7

while true do
	local cells = find_cells()
	local msg = "cells:"..id
	for n, cell in cells do
		local max = cell.getMaxEnergyStored()
		local cur = cell.getEnergyStored()
		msg = msg .. ":" .. cur .. "/" max
	print(msg)
	sleep(3)



--getActivationEnergy
--getLatency
--getMinEnergyReceived
--getMaxEnergyReceived
--getMaxEnergyStored
--getEnergyStored
--getPowerProvider
--getEnergySend
--getEnergyReceive
