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
--		print(textutils.serialize(t))
		for m, t2 in pairs(t) do
			if t2.name == "tile.oilStill" then
				self.oil.cap = self.oil.cap + t2.capacity
				self.oil.cur = self.oil.cur + t2.amount
			elseif t2.name == "item.fuel" then
				self.fuel.cap = self.fuel.cap + t2.capacity
				self.fuel.cur = self.fuel.cur + t2.amount
			end
			print(t2.name)
			print(t2.capacity)
			print(t2.amount)
		end
	end
end

local p = Power.new()
p:find()
p:liq()
print(textutils.serialize(p.oil))
print(textutils.serialize(p.fuel))

