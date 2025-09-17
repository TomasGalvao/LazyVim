local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
local configuration_dir = home .. "/.cache/jdtls/config/" .. project_name

local function find_root(markers)
	local cwd = vim.fn.getcwd()
	local path_sep = package.config:sub(1, 1)

	local function path_join(...)
		return table.concat({ ... }, path_sep)
	end

	local function is_root(path)
		for _, marker in ipairs(markers) do
			if vim.fn.glob(path_join(path, marker)) ~= "" then
				return true
			end
		end
		return false
	end

	local function traverse_up(path)
		local parent = vim.fn.fnamemodify(path, ":h")
		if path == parent then
			return nil
		elseif is_root(path) then
			return path
		else
			return traverse_up(parent)
		end
	end

	return traverse_up(cwd) or cwd
end

local root_dir = find_root({ ".git", "mvnw", "gradlew" })

return {
	cmd = { "jdtls", "-configuration", configuration_dir, "-data", workspace_dir },
	filetypes = { "java" },
	root_dir = root_dir,
	init_options = {
		jvm_args = {},
		workspace = home .. "/.cache/jdtls/workspace" .. project_name,
	},
	-- settings = {
	-- 	workspace_folder = workspace_dir,
	-- },
}
