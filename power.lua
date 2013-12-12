local Power = {}
Power.__index = Power

function Power.new(init)
	local self = setmetatable({}, Power)
	self.cells = {}
	self.tanks = {}
	self:init_liquids()
	return self
end

function Power.init_liquids(self)
	self.oil = {cap=0, cur=0}
	self.fuel = {cap=0, cur=0}
	self.lava = {cap=0, cur=0}
end

function Power.find(self)
	local names = peripheral.getNames()
	self.cells = {}
	self.tanks = {}
	for n, name in pairs(names) do
		local typ = peripheral.getType(name)
		if typ == "redstone_energy_cell" then
			table.insert(self.cells, peripheral.wrap(name))
		elseif typ == "tile_tankblock" then
			table.insert(self.tanks, peripheral.wrap(name))
		end
	end
end

function Power.liq(self)
	self:init_liquids()
	for n, tank in pairs(self.tanks) do
		local t = tank.getTanks("unknown")
		print(textutils.serialize(t))
	end
end

local p = Power.new()
print(p)
