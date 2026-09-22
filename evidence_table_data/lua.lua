local p = {}

local word_filters = require("word_filters.lua")
local ijy_corde_forms = require("ijy_corde_forms.lua")

local data_of_interest = {}
for i, form in ipairs(ijy_corde_forms) do
	for header, data in pairs(word_filters.word_patterns) do
		if string.match(form["Transcripción"], data["Pattern"]) then
			table.insert(
				data_of_interest,
				{
					["Transcripción"] = form["Transcripción"],
					["Forma"] = form["Forma"],
					["Datos"] = form["Datos"],
					["Header"] = header,
					["Class"] = data["Class"],
					["Pattern"] = data["Pattern"]
				}
			)
		end
	end
end

return p