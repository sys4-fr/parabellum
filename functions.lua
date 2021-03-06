-- -- -- 
-- spawnpoint --
-- -- --

minetest.register_privilege("setspawn", {
	description = "Can use /setspawn command",
	give_to_singleplayer = false
})

minetest.register_chatcommand("setspawn", {
	params = "<name> <X>,<Y>,<Z>",
	description = "Set spawn of player to <X>,<Y>,<Z>",
	privs = {setspawn=true},
	func = function(name, param)
		local target = nil
		local p = {}
		local targetn = nil
		local lm = 31000
		targetn_t, p.x, p.y, p.z = param:match(
				"^([^ ]+) +([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if not targetn_t or not p.x or not p.y or not p.z then
			return false, "Invalid parameters (see /help setspawn)"
		elseif not core.get_auth_handler().get_auth(targetn_t) then
			return false, "Player " .. targetn_t .. " does not exist."
		end
		p.x, p.y, p.z = tonumber(p.x), tonumber(p.y), tonumber(p.z)
			if p.x < -lm or p.x > lm or p.y < -lm or p.y > lm or p.z < -lm or p.z > lm then
				return false, "Cannot spawn out of map bounds!"
			end
		if p.x and p.y and p.z then
		if targetn_t then
					if not core.get_player_by_name(targetn_t) then
							return false, "The player " .. targetn_t
										.. " is not online."
					end
			target = core.get_player_by_name(targetn_t)	
				minetest.register_on_respawnplayer(function(player)
					local pos = ({x=p.x, y=p.y, z=p.z})
					local name = player:get_player_name()
					if target == player then
						if pos then
							player:setpos(pos)
							return true
						end
					end
end)
		end
	return true, "Spawn of " ..targetn_t.. " set."
	end
end
})
