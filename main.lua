filesystem = NFS or love.filesystem
shdwn_shitty = SMODS.current_mod
mod_path = shdwn_shitty.path
Showdown_Shitty.config = shdwn_shitty.config

filesystem.load(mod_path.."functions.lua")()
SMODS.Atlas({key = "shdwn_shitty_modicon", path = "ModIcon.png", px = 36, py = 36})

local files = filesystem.getDirectoryItems(mod_path.."items/")
for _, file in ipairs(files) do
	sendTraceMessage("Loading file "..file, "Showdown: Shitty Jokers")
	local f, err = SMODS.load_file("Items/" .. file)
	if err then
		sendErrorMessage("Error loading file: "..err, "Showdown: Shitty Jokers")
	else
		local item = f()
		if item and item.enabled then
			if item.exec then item.exec() end
			if item.atlases then
				for _, atlas in ipairs(item.atlases) do
					SMODS.Atlas(atlas)
				end
			end
			if item.list then
				local list = item.list()
				for _, obj in ipairs(list) do
					if obj.type and SMODS[obj.type] then
						SMODS[obj.type](obj)
					end
				end
			end
			if item.post_exec then item.post_exec() end
		end
	end
end

function shdwn_shitty.save_config(self)
    SMODS.save_mod_config(self)
end

local showdown_config_tab = function()
	return{
		{
		label = localize("showdown_content_config"),
		chosen = true,
		tab_definition_function = function()
		return {
			n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = {
				
					{n=G.UIT.R, config={align = "cm"}, nodes={
						
						{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_restart"), colour = G.C.RED, scale = 0.4}}}},
						}},
				
					{n=G.UIT.R, config={align = "cm"}, nodes={ --Base Box containing everything
		
						-- Left Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={

								create_toggle({label = localize("showdown_config_ranks"), ref_table = Showdown_Shitty.config, ref_value = 'Ranks', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("shdwn_shitty_config_jokers"), ref_table = Showdown_Shitty.config, ref_value = 'Jokers', callback = function() shdwn:save_config() end}),

							}},
						}},
					
					}}
				},
		}
		end
		},
	}
end

shdwn.extra_tabs = showdown_config_tab
shdwn.config_tab = true