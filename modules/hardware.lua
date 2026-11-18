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

function hw.init()
	-- Ender modem
	hw.ender_modem = find_req("modem", function(_, wrapped)
		return wrapped.isWireless()
	end)

	-- Sensors and detectors
	hw.altitude = find_req("altitude_sensor")
	hw.distance_height = find_req("distance_detector")
	hw.gimbal = find_req("gimbal_sensor")
	hw.player = find_req("player_detector")
	hw.velocity = find_req("velocity_sensor")
	hw.rs_bridge = find_req("redstone_link_bridge")
	hw.fluid_vessel = find_req("fluid_tank")
end

return hw
