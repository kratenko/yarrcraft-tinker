local Loot = {}
Loot.__index = Loot


function Loot.new(init)
	local self = setmetatable({}, Loot)
	self.cells = {}
	self.tanks = {}
	self:init_liquids()
	return self
end


function Loot.init_liquids(self)
	self.oil = {capacity=0, amount=0, count=0}
	self.fuel = {capacity=0, amount=0, count=0}
	self.lava = {capacity=0, amount=0, count=0}
	self.empty = {capacity=0, amount=0, count=0}
	self.power = {capacity=0, amount=0, count=0}
end


function Loot.find(self)
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


function Loot.do_liquids(self)
	self:init_liquids()
	for n, tank in pairs(self.tanks) do
		local t = tank.getTanks("unknown")
--		print(textutils.serialize(t))
		for m, t2 in pairs(t) do
			if t2.name == "tile.oilStill" then
				self.oil.count = self.oil.count + 1
				self.oil.capacity = self.oil.capacity + t2.capacity
				self.oil.amount = self.oil.amount + t2.amount
			elseif t2.name == "item.fuel" then
				self.fuel.count = self.fuel.count + 1
				self.fuel.capacity = self.fuel.capacity + t2.capacity
				self.fuel.amount = self.fuel.amount + t2.amount
			elseif t2.name == "tile.lava" then
				self.lava.count = self.lava.count + 1
				self.lava.capacity = self.lava.capacity + t2.capacity
				self.lava.amount = self.lava.amount + t2.amount
			end
			print(t2.name)
			print(t2.capacity)
			print(t2.amount)
		end
	end
end


function Loot.do_power(self)
	self.power = {capacity=0, amount=0, count=0}
	for n, cell in pairs(self.cells) do
		self.power.count = self.power.count + 1
		self.power.capacity = self.power.capacity + cell.getMaxEnergyStored()
		self.power.amount = self.power.amount + cell.getEnergyStored()
	end
end


local p = Loot.new()
p:find()
p:do_liquids()
p:do_power()
print("oil")
print(textutils.serialize(p.oil))
print("fuel")
print(textutils.serialize(p.fuel))
print("power")
print(textutils.serialize(p.power))
print("lava")
print(textutils.serialize(p.lava))

