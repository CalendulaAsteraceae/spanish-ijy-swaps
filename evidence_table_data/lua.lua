local p = {}

local word_filters = require("word_filters.lua")
local ijy_corde_forms = require("ijy_corde_forms.lua")

local function remove_duplicates(array)
    if not array or type(array) ~= "table" then
        return array
    end
    local deduped_array = {}
    local exists = {}
    for i, v in ipairs(array) do
        if type(v) == "number" and v ~= v then
            table.insert(deduped_array, v)
        elseif not exists[v] then
            table.insert(deduped_array, v)
            exists[v] = true
        end
    end
    return deduped_array
end

-- uses hardcoded exceptions, should be reevaluated if more words are added
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

local letters_by_class = {}
for class, v in pairs(word_filters["class_labels"]) do
	letters_by_class[class] = {}
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
				local d = word_data(class, merged_data)
				if d then
					table.insert(representative_words, d)
					table.insert(letters_by_class[class], d["Letra"])
				end
			end
		end
	end
end
for class, v in ipairs(word_filters["class_labels"]) do
	letters_by_class[class] = remove_duplicates(letters_by_class[class])
	table.sort(letters_by_class[class])
end

function p.print_representative_words()
	local printable_table = {
		"Clase  Letra  Correspondencia  Transcripción  Forma  –1200  1201–1250  1251–1300  1301–1350  1351–1400  1401–1450  1451–1500  1501–1550  1551–1600" -- hardcoded
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
					table.concat(data["Datos"], "  ")
				},
				"  "
			)
		)
	end
	return table.concat(printable_table, "\n")
end

local letter_frequencies = {}
local default_letter_frequencies = {0, 0, 0, 0, 0, 0, 0, 0, 0} -- hardcoded
for class, class_data in pairs(word_filters["class_labels"]) do
	letter_frequencies[class] = {}
	for i, letter in ipairs(letters_by_class[class]) do
		letter_frequencies[class][letter] = default_letter_frequencies
	end
end
for i, data in ipairs(representative_words) do
	local class = data["Clase"]
	for j, n in ipairs(data["Datos"]) do
		letter_frequencies[data["Clase"]][data["Datos"]][j] = letter_frequencies[data["Clase"]][data["Datos"]][j] + n
	end
end

function p.print_letter_frequencies()
	local printable_table = {
		"Class  Letter  –1200  1201–1250  1251–1300  1301–1350  1351–1400  1401–1450  1451–1500  1501–1550  1551–1600" -- hardcoded
	}
	for class, class_data in ipairs(word_filters["class_labels"]) do
		local class_letter_data = {}
		for i, letter in ipairs(letters_by_class[class]) do
			table.insert(
				class_letter_data,
				table.concat(
					{
						word_filters["class_labels"][class]["text"],
						letter,
						table.concat(letter_frequencies[class][letter] or default_letter_frequencies, "  ")
					},
					"  "
				)
			)
		end
		printable_table[class_data["index"] + 1] = table.concat(class_letter_data, "\n")
	end
	return table.concat(printable_table, "\n")
end

return p