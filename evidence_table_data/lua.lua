local p = {}

local word_filters = require("word_filters.lua")
local ijy_corde_forms = require("ijy_corde_forms.lua")

local function word_data(class, data)
	local letra
	if class == "g-" or class == "i-" or class == "y.-" then
		letra = string.match(data["Transcripción"], "^h?(" .. word_filters["patterns"]["swapletters"] .. ")")
	elseif class == "-i" or class == "-.y" then
		letra = string.match(data["Transcripción"], "(" .. word_filters["patterns"]["swapletters"] .. ")$")
	elseif class == "-g-" or class == "-i-" or class == "-.y-" or class == "-y.-" then
		if word_filters["manual_word_medial_patterns"][class][data["Correspondencia"]] then
			letra = word_filters["manual_word_medial_patterns"][class][data["Correspondencia"]](data["Transcripción"])
		else
			letra = string.match(data["Transcripción"], word_filters["word_medial_patterns"][class])
		end
	end
	if letra then
		return {
			["Transcripción"] = data["Transcripción"],
			["Forma"] = data["Forma"],
			["Datos"] = data["Datos"],
			["Correspondencia"] = data["Correspondencia"],
			["Clase"] = class,
			["Letra"] = letra
		}
	end
	return nil
end

local representative_words = {}
for i, form in ipairs(ijy_corde_forms) do
	for correspondencia, data in pairs(word_filters["word_patterns"]) do
		if string.match(form["Transcripción"], data["Pattern"]) then
			local classes = data["Class"]
			local merged_data = {
				["Transcripción"] = form["Transcripción"],
				["Forma"] = form["Forma"],
				["Datos"] = form["Datos"],
				["Correspondencia"] = correspondencia
			}
			for j, class in ipairs(classes) do
				table.insert(data_to_process, word_data(class, merged_data))
			end
		end
	end
end

function p.print_representative_words()
	local printable_table = {
		"Clase	Letra	Correspondencia	Transcripción	Forma	–1200	1201–1250	1251–1300	1301–1350	1351–1400	1401–1450	1451–1500	1501–1550	1551–1600"
	}
	for i, data in ipairs(representative_words) do
		table.insert(
			printable_table,
			table.concat(
				{
					word_filters["class_labels"][data["Clase"]],
					data["Letra"],
					data["Correspondencia"],
					data["Transcripción"],
					data["Forma"],
					data["Datos"]
				},
				"\t"
			)
		)
	end
	return table.concat(printable_table, "\n")
end

return p