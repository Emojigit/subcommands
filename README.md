# Subcommands
This mod adds an API to create commands with subcommands.
## Functions
### `subcommands.register_command_with_subcommand(name, def)`
The definition table is similar to the [Chat command definition for the Minetest API](https://minetest.gitlab.io/minetest/definition-tables/#chat-command-definition), except:
* The `func` field should be left empty
* The `_sc_def` field should be a table of subcommands. Each entry should be indexed by the name of the subcommand and have the following definition:
```lua
{
	description = "subcommand description",
	params = "<params>",
	privs = {required_privs = true}, -- Optional
	func = function(name,param) return true,"The function" end -- Just like func in minetest.register_chatcommand
}
```
The `help` subcommand is reserved and should not be used
### `subcommands.subcommand_handler(sc_def,cm_name)`
Returns a handler for the command. This is mainly intended for internal use.
* `sc_def`: subcommand definition (see above)
* `cm_name`: name of the command
