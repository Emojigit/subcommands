# Subcommands
this is a minetest API to creating commands with subcommands.
## Method
### `subcommands.register_command_with_subcommand(name.def)`
same as `minetest.register_chatcommand`, but:
 - Don't fill anything in `func` def.
 - add `def._sc_def`(Dict)
#### `def._sc_def`
```
{
  subcommand_name = {
    description = "subcommand description"
    params = "<params>"
    func = function(name,param) return true,"The function" end -- Just like func in minetest.register_chatcommand
  }
}
```
### `subcommands.subcommand_handler(sc_def,cm_name)`
No usage
