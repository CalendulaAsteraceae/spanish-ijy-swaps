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
	local manual_matching_function = word_filters["class_labels"]["manual_word_match_patterns"][class][data["Correspondencia"]]
	if type(manual_matching_function) == "table" then
		letra = {}
		for i, f in ipairs(manual_matching_function) do
			table.insert(letra, string.match(data["Transcripción"], f))
		end
	elseif manual_matching_function then
		letra = string.match(data["Transcripción"], manual_matching_function)
	else
		letra = string.match(data["Transcripción"], word_filters["class_labels"]["word_match_patterns"][class])
	end
	if type(letra) == "string" then
		letra = {letra}
	end
	if letra then
		local data_with_letters = {}
		for i, l in ipairs(letra) do
			table.insert(
				data_with_letters,
				{
					["Transcripción"] = data["Transcripción"],
					["Forma"] = data["Forma"],
					["Datos"] = data["Datos"],
					["Correspondencia"] = data["Correspondencia"],
					["Clase"] = class,
					["Letra"] = l
				}
			)
		end
		return data_with_letters
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
				local ds = word_data(class, merged_data)
				if ds then
					for k, d in ipairs(ds) do
						table.insert(representative_words, d)
					end
				end
			end
		end
	end
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
					word_filters["class_labels"][data["Clase"]]["text"],
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
for class, class_data in pairs(word_filters["class_labels"]) do
	letter_frequencies[class] = {}
	for i, letter in ipairs(word_filters["class_labels"][class]["letters"]) do
		letter_frequencies[class][letter] = {0, 0, 0, 0, 0, 0, 0, 0, 0} -- hardcoded
	end
end
for i, data in ipairs(representative_words) do
	local class = data["Clase"]
	local letter = data["Letra"]
	for j, n in ipairs(data["Datos"]) do
		local running_total = letter_frequencies[class][letter][j] 
		letter_frequencies[class][letter][j] = running_total + n
	end
end

function p.print_letter_frequencies()
	local printable_table = {
		"Class  Letter  –1200  1201–1250  1251–1300  1301–1350  1351–1400  1401–1450  1451–1500  1501–1550  1551–1600" -- hardcoded
	}
	for class, class_data in pairs(word_filters["class_labels"]) do
		local class_letter_data = {}
		for i, letter in ipairs(class_data["letters"]) do
			table.insert(
				class_letter_data,
				table.concat(
					{
						class_data["text"],
						letter,
						table.concat(letter_frequencies[class][letter], "  ")
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