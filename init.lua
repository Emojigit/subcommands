subcommands = {}
local _sc = subcommands

local function splitonce(s, p)
	local b, e = string.find(s, p, 1, true)
	if b then
		return string.sub(s, 1, b-1), string.sub(s, e+1, -1)
	else
		return s, ""
	end
end

_sc.subcommand_handler = function(sc_def,cm_name)
	return function(name,param)
		local subcommand, _param = splitonce(param," ")
		minetest.log("action",name.."issued command "..cm_name.." with subcommand "..subcommand)
		if sc_def[subcommand] then
			if minetest.check_player_privs(name,sc_def[subcommand].privs or {}) then
				return sc_def[subcommand].func(name,_param)
			else
				return false, "No privs to do this!"
			end
		end
		return false, "unknown subcommand, see /"..cm_name.." help"
	end
end

_sc.register_command_with_subcommand = function(name,def)
	local sc_def = def._sc_def
	local sc_help = {}
	for k,v in pairs(sc_def) do
		local description = v.description
		local params = v.params
		sc_help[k] = "/"..name.." "..k.." "..params.." : "..description
	end
	sc_def["help"] = {
		description = "Get subcommands help",
		params = "[subcommand]",
		func = function(name,param)
			if param == "" then
				for k,v in pairs(sc_help) do
					minetest.chat_send_player(name, v)
				end
				return true
			else
				if sc_help[param] then return true, sc_help[param] end
				return false, "unknown subcommand: "..tostring(param)
			end
		end,
		
	}
	def.func = _sc.subcommand_handler(sc_def,name)
	return minetest.register_chatcommand(name,def)
end

_sc.register_command_with_subcommand("subcommand_test",{
	description = "Config Markers",
	_sc_def = {
		server = {
			description = "Command that only player with server privs can run",
			privs = {server = true},
			params = "",
			func = function(name,param)
				return true, "Your name: "..name.."\nparam: "..param.."\nServer subcommand"
			end
		},
		test = {
			description = "Command that everyone can run",
			params = "",
			func = function(name,param)
				return true, "Your name: "..name.."\nparam: "..param.."\nTest subcommand"
			end
		},
	},
})

















