local hw = {}

-- Find peripheral
local function find_req(p_type, filter)
	local dev = peripheral.find(p_type, filter)
	if not dev then
		error("Could not find " .. p_type, 2)
	end
	print("Found", p_type)
	return dev
end

function hw:init()
	-- Ender modem
	self.ender_modem = find_req("modem", function(_, wrapped)
		return wrapped.isWireless()
	end)

	-- Sensors and detectors
	self.altitude = find_req("altitude_sensor")
	-- self.distance_height = find_req("distance_detector")
	self.optical = find_req("optical_sensor")
	self.gimbal = find_req("gimbal_sensor")
	self.player = find_req("player_detector")
	self.velocity = find_req("velocity_sensor")
	self.rs_bridge = find_req("redstone_link_bridge")
	self.fluid_tank = find_req("fluid_tank")
end

-- Distance detector, altitude sensor
function hw:getHeight(terrain)
	if not terrain then
		return self.altitude.getHeight()
	end
	return -1
	-- return self.distance_height.getDistance()
end

function hw:getAirPressure()
	return self.altitude.getAirPressure()
end

-- Gimbal sensor
function hw:getAngles(rad)
	if not rad then
		return self.gimbal.getAngles()
	end
	return self.gimbal.getAnglesRad()
end

function hw:getAngularRates(rad)
	if not rad then
		return self.gimbal.getAngularRates()
	end
	return self.gimbal.getAngularRatesRad()
end

-- Velocity sensor
function hw:getForwardVelocity()
	return self.velocity.getVelocity()
end

-- Redstone link bridge
function hw:getLink(freq1, freq2)
	return self.rs_bridge.getLinkSignal(freq1, freq2)
end

function hw:setLink(freq1, freq2, signal)
	self.rs_bridge.sendLinkSignal(freq1, freq2, signal)
end

-- Fluid tank
function hw:getFuel()
	tank = self.fluid_tank.tanks()[1]
	if not tank then
		return 0, "empty"
	end
	return tank.amount, tank.name
end

-- TODO: Player detector

return hw
