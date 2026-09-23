local p = {}

local word_filters = require("word_filters.lua")
local ijy_corde_forms = require("ijy_corde_forms.lua")

local data_to_process = {}
for i, form in ipairs(ijy_corde_forms) do
	for correspondencia, data in pairs(word_filters.word_patterns) do
		if string.match(form["Transcripción"], data["Pattern"]) then
			table.insert(
				data_to_process,
				{
					["Transcripción"] = form["Transcripción"],
					["Forma"] = form["Forma"],
					["Datos"] = form["Datos"],
					["Correspondencia"] = correspondencia,
					["Clase"] = data["Class"]
				}
			)
		end
	end
end

local representative_words = {}

for i, data in ipairs(data_to_process) do
	if #data["Clase"] == 1 then
		table.insert(
			representative_words,
			{
				["Transcripción"] = data["Transcripción"],
				["Forma"] = data["Forma"],
				["Datos"] = data["Datos"],
				["Correspondencia"] = data["Correspondencia"],
				["Clase"] = data["Clase"],
				["Letra"] = string.match(data["Transcripción"], "(" .. word_filters.patterns.swapletters .. ")")
			}
		)
	else
		for j, class in ipairs(data["Clase"]) do
			local letra
			if class == "g-" or class == "i-" or class == "y.-" then
				if string.sub(data["Transcripción"], 1, 1) == "h" then
					letra = string.sub(data["Transcripción"], 2, 2)
				else
					letra = string.sub(data["Transcripción"], 1, 1)
				end
			elseif class == "-i" or class == "-.y" then
				letra = string.sub(data["Transcripción"], -1, -1)
			elseif class == "-g-" or class == "-i-" or class == "-.y-" or class == "-y.-" then
				if word_filters.manual_word_medial_patterns[class][data["Correspondencia"]] then
					letra = word_filters.manual_word_medial_patterns[class][data["Correspondencia"]](data["Transcripción"])
				else
					letra = string.match(data["Transcripción"], word_filters.word_medial_patterns[class])
				end
			end
			table.insert(
				representative_words,
				{
					["Transcripción"] = data["Transcripción"],
					["Forma"] = data["Forma"],
					["Datos"] = data["Datos"],
					["Correspondencia"] = data["Correspondencia"],
					["Clase"] = data["Clase"],
					["Letra"] = letra
				}
			)
		end
	end
end

return p