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

local function letter_for_class(class, data)
	local letra
	if class == "g-" or class == "i-" or class == "y.-" then
		letra = string.match(data["Transcripción"], "^h?(" .. word_filters.patterns.swapletters .. ")")
	elseif class == "-i" or class == "-.y" then
		letra = string.match(data["Transcripción"], "(" .. word_filters.patterns.swapletters .. ")$")
	elseif class == "-g-" or class == "-i-" or class == "-.y-" or class == "-y.-" then
		if word_filters.manual_word_medial_patterns[class][data["Correspondencia"]] then
			letra = word_filters.manual_word_medial_patterns[class][data["Correspondencia"]](data["Transcripción"])
		else
			letra = string.match(data["Transcripción"], word_filters.word_medial_patterns[class])
		end
	end
	return letra
end

local representative_words = {}
for i, data in ipairs(data_to_process) do
	if #data["Clase"] == 1 then
		local class = data["Clase"][1]
		local letra = letter_for_class(class, data)
		if letra then
			table.insert(
				representative_words,
				{
					["Transcripción"] = data["Transcripción"],
					["Forma"] = data["Forma"],
					["Datos"] = data["Datos"],
					["Correspondencia"] = data["Correspondencia"],
					["Clase"] = class,
					["Letra"] = letra
				}
			)
		end
	elseif #data["Clase"] > 1 then
		for j, class in ipairs(data["Clase"]) do
			local letra = letter_for_class(class, data)
			if letra then
				table.insert(
					representative_words,
					{
						["Transcripción"] = data["Transcripción"],
						["Forma"] = data["Forma"],
						["Datos"] = data["Datos"],
						["Correspondencia"] = data["Correspondencia"],
						["Clase"] = class,
						["Letra"] = letra
					}
				)
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
					word_filters.class_labels[data["Clase"]],
					data["Letra"],
					data["Correspondencia"],
					data["Transcripción"],
					data["Forma"],
					data["Datos"]
				},
				"	"
			)
		)
	end
	return table.concat(printable_table, "\n")
end

return p