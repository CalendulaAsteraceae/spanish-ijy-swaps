local word_filters = {}

word_filters.patterns = {
	["b"] = "[buv]+",
	["g"] = "[gijx]",
	["i"] = "[ijy]",
	["j"] = "[ijx]",
	["k"] = "[ckq]+",
	["n"] = "[mn]+",
	["s"] = "[csz]+",
	["u"] = "[uv]+",
	["swapletters"] = "[gijxy]",
	["ae"] = "[ae]+",
	["ao"] = "[ao]+",
	["eo"] = "[eo]+",
	["aeo"] = "[aeo]+",
	["mos"] = "[mn]+o+[csz]+",
	["ste"] = "[csz]+t+e+",
	["mos|n|s"] = "[mncszo]+",
	["mos|ste"] = "[mncszteo]+",
	["e(r|s)(a|e)is"] = "e[rcsz]+[ae]+[ijy]+[csz]+",
	["e(r|s)(a|e)(mos|n|s)?"] = "e[rcsz]+[ae]+[mncszo]*"
}

word_filters["class_labels"] = {
	["i-"] = {["text"] = "Word-initial vowel /i/", ["index"] = 1, ["letters"] = {"hi", "hj", "hy", "i", "j", "y"}},
	["-i-"] = {["text"] = "Word-medial vowel /i/", ["index"] = 2, ["letters"] = {"i", "j", "y"}},
	["-i"] = {["text"] = "Word-final vowel /i/", ["index"] = 3, ["letters"] = {"i", "j", "y"}},
	["y.-"] = {["text"] = "Word-initial semivowel /j/ starting a diphthong", ["index"] = 4, ["letters"] = {"i", "j", "y"}},
	["-y.-"] = {["text"] = "Word-medial semivowel /j/ starting a diphthong", ["index"] = 5, ["letters"] = {"i", "j", "y"}},
	["-.y-"] = {["text"] = "Word-medial semivowel /j/ ending a diphthong", ["index"] = 6, ["letters"] = {"i", "j", "y"}},
	["-.y"] = {["text"] = "Word-final semivowel /j/ ending a diphthong", ["index"] = 7, ["letters"] = {"i", "j", "y"}},
	["g-"] = {["text"] = "Word-initial consonant /d͡ʒ/ or /ʃ/", ["index"] = 8, ["letters"] = {"g", "i", "j", "x"}},
	["-g-"] = {["text"] = "Word-medial consonant /d͡ʒ/ or /ʃ/", ["index"] = 9, ["letters"] = {"g", "i", "j", "x"}}
}

word_filters.word_patterns = {
	["Aire(s)?"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["i"] .. "r+" .. "e+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Ajo(s)?"] = {
		["Class"] = {"-g-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["j"] .. "o+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Antoni(o|a)"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. "n+" .. "t+" .. "o+" .. "n+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["ao"] .. "$"
	},
	["Ayer"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. "$"
	},
	["Catalina"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. word_filters["patterns"]["k"] .. "a+" .. "t+" .. "a+" .. "l+" .. word_filters["patterns"]["i"] .. "n+" .. "a+" .. "$"
	},
	["Cid"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "d+" .. "$"
	},
	["Cidi"] = {
		["Class"] = {"-i-", "-i"},
		["Pattern"] = "^" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "d+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Elvira"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "l+" .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. "r+" .. "a+" .. "$"
	},
	["Escogi"] = {
		["Class"] = {"-g-", "-i"},
		["Pattern"] = "^" .. "h*" .. "e+" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["k"] .. "o+" .. word_filters["patterns"]["g"] .. word_filters["patterns"]["i"] .. "$"
	},
	
	["Fue(r|s)(a|e)is"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "f+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["e(r|s)(a|e)is"] .. "$"
	},
	["Fui"] = {
		["Class"] = {"-i"},
		["Pattern"] = "^" .. "f+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. "$"
	},
	["Fui(mos|ste)"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "f+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["mos|ste"] .. "$"
	},
	["Fuisteis"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "f+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "t+" .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	
	["General"] = {
		["Class"] = {"g-"},
		["Pattern"] = "^" .. word_filters["patterns"]["g"] .. "+" .. "e+" .. "n+" .. "e+" .. "r+" .. "a+" .. "l+" .. "$"
	},
	["Gentil"] = {
		["Class"] = {"g-", "-i-"},
		["Pattern"] = "^" .. word_filters["patterns"]["g"] .. "+" .. "e+" .. "n+" .. "t+" .. word_filters["patterns"]["i"] .. "l+" .. "$"
	},
	["Guiomar"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "g+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. "o+" .. "m+" .. "a+" .. "r+" .. "$"
	},
	
	["Habeis"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hab(r)?iais"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. "+" .. "r*" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hab(r)?ia(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. "+" .. "r*" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Habid(o|a)(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. "d+" .. word_filters["patterns"]["ao"] .. "+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Habiendo"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. "e+" .. "n+" .. "d+" .. "o+" .. "$"
	},
	["Habreis"] = {
		["Class"] = {"-.y"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["b"] .. "r+" .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hay"] = {
		["Class"] = {"-.y"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Hayais"] = {
		["Class"] = {"-y.-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Haya(mos|n|s)?"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Hubie(r|s)(a|e)is"] = {
		["Class"] = {"-y.-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)is"] .. "$"
	},
	["Hubie(r|s)(a|e)(mos|n|s)?"] = {
		["Class"] = {"-i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)(mos|n|s)?"] .. "$"
	},
	["Hubieron"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. "+" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. "o+" .. "n+" .. "$"
	},
	["Hubi(mos|ste)"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. "+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["mos|ste"] .. "$"
	},
	["Hubisteis"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. "+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "t+" .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	
	["Haceis"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["s"] .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Haciais"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hacia(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Haciendo"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "e+" .. "n+" .. "d+" .. "o+" .. "$"
	},
	["Hagais"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. "g+" .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hareis"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. "r+" .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Hariais"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Haria(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "a+" .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Hi(ce|zo)"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["eo"] .. "$"
	},
	["Hicie(r|s)(a|e)is"] = {
		["Class"] = {"i-", "-y.-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)is"] .. "$"
	},
	["Hicie(r|s)(a|e)(mos|n|s)?"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)(mos|n|s)?"] .. "$"
	},
	["Hicieron"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. "o+" .. "n+" .. "$"
	},
	["Hici(mos|ste)"] = {
		["Class"] = {"i-", "-i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["mos|ste"] .. "$"
	},
	["Hicisteis"] = {
		["Class"] = {"i-", "-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "t+" .. "e+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	
	["Heri"] = {
		["Class"] = {"-i"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Heria(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Herid(o|a)(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "d+" .. word_filters["patterns"]["ao"] .. "*" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Herimos"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "m+" .. "o+" .. word_filters["patterns"]["s"] .. "+" .. "$"
	},
	["Herir(a|e)is"] = {
		["Class"] = {"-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. "*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. "$"
	},
	["Herir(a|e)(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. "*" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Heriria(mos|n|s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Her(is|iste)"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. "e+" .. "r+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "t*" .. "e*" .. "$"
	},
	["Hier(a|e|o)(mos|n|s)?"] = {
		["Class"] = {"y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. word_filters["patterns"]["aeo"] .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["(Hi|i)r(a|e)is"] = {
		["Class"] = {"i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. "$"
	},
	["(Hi|i)r(a|e)(mos|n|s)?"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. "m+" .. "o+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Hirien(do|te)"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. "e+" .. "n+" .. "[dote]+" .. "$"
	},
	["Hirie(r|s)(a|e)is"] = {
		["Class"] = {"i-", "-y.-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)is"] .. "$"
	},
	["Hirie(r|s)(a|e)(mos|n|s)?"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["e(r|s)(a|e)(mos|n|s)?"] .. "$"
	},
	["Hir(io|ieron)"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["eo"] .. "[romn]*" .. "$"
	},
	
	["Hierba(s)?"] = {
		["Class"] = {"y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Hij(o|a)(s)?"] = {
		["Class"] = {"i-", "-g-"},
		["Pattern"] = "^" .. "h?[ijy]" .. word_filters["patterns"]["j"] .. word_filters["patterns"]["ao"] .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	
	["Ibarra"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["b"] .. "a+" .. "r+" .. "a+" .. "$"
	},
	["Iglesia(s)?"] = {
		["Class"] = {"i-", "-y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "g+" .. "l+" .. "e+" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Inez"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "n+" .. "e+" .. word_filters["patterns"]["s"] .. "+" .. "$"
	},
	["Iñig(o|a)"] = {
		["Class"] = {"i-", "-i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "n+" .. word_filters["patterns"]["i"] .. "g+" .. word_filters["patterns"]["ao"] .. "$"
	},
	
	["Ibais"] = {
		["Class"] = {"i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Iba(mos|n|s)?"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Id(o|a)?(s)?"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "d+" .. word_filters["patterns"]["ao"] .. "*" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Ir"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. "$"
	},
	["Ir(a|e)is"] = {
		["Class"] = {"i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Ir(a|e)(mos|n|s)?"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["ae"] .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Iriais"] = {
		["Class"] = {"i-", "-i-", "-.y-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Iria(mos|n|s)?"] = {
		["Class"] = {"i-", "-i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "r+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "*" .. "$"
	},
	["Vais"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Vayais"] = {
		["Class"] = {"-y.-", "-.y-"},
		["Pattern"] = "^" .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "$"
	},
	["Vaya(mos|n|s)"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. word_filters["patterns"]["b"] .. "a+" .. word_filters["patterns"]["i"] .. "a+" .. word_filters["patterns"]["mos|n|s"] .. "$"
	},
	
	["Isabel(a)?"] = {
		["Class"] = {"i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "a+" .. word_filters["patterns"]["b"] .. "e+" .. "l+" .. "a*" .. "$"
	},
	["Jaime"] = {
		["Class"] = {"g-", "-.y-"},
		["Pattern"] = "^" .. word_filters["patterns"]["j"] .. "a+" .. word_filters["patterns"]["i"] .. "m+" .. "e+" .. "$"
	},
	["Javier"] = {
		["Class"] = {"g-", "-y.-"},
		["Pattern"] = "^" .. word_filters["patterns"]["j"] .. "a+" .. word_filters["patterns"]["b"] .. word_filters["patterns"]["i"] .. "e+" .. "r" .. "$"
	},
	["Juan(a)?"] = {
		["Class"] = {"g-"},
		["Pattern"] = "^" .. word_filters["patterns"]["j"] .. word_filters["patterns"]["u"] .. "a+" .. "n+" .. "a*" .. "$"
	},
	["Juicio(s)?"] = {
		["Class"] = {"g-", "-i-", "-y.-"},
		["Pattern"] = "^" .. word_filters["patterns"]["j"] .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "o+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Juli(o|a)"] = {
		["Class"] = {"g-", "-y.-"},
		["Pattern"] = "^" .. word_filters["patterns"]["j"] .. word_filters["patterns"]["u"] .. "l+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["ao"] .. "$"
	},
	["Lira(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "l+" .. word_filters["patterns"]["i"] .. "r+" .. "a+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Luis(a)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "l+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "a*" .. "$"
	},
	["Mayor(es)?"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. "m+" .. "a+" .. word_filters["patterns"]["i"] .. "o+" .. "r+" .. "e*" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Mi(o|a)(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "m+" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["ao"] .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Muy"] = {
		["Class"] = {"-.y"},
		["Pattern"] = "^" .. "m+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. "$"
	},
	["Ojo(s)?"] = {
		["Class"] = {"-g-"},
		["Pattern"] = "^" .. "h*" .. "o+" .. word_filters["patterns"]["j"] .. "o+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["parti"] = {
		["Class"] = {"-i"},
		["Pattern"] = "^" .. "p+" .. "a+" .. "r+" .. "t+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Protegi"] = {
		["Class"] = {"-g-", "-i"},
		["Pattern"] = "^" .. "p+" .. "r+" .. "o+" .. "t+" .. "e+" .. word_filters["patterns"]["g"] .. word_filters["patterns"]["i"] .. "$"
	},
	["Rey"] = {
		["Class"] = {"-.y"},
		["Pattern"] = "^" .. "r+" .. "e+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Reyno"] = {
		["Class"] = {"-.y-"},
		["Pattern"] = "^" .. "r+" .. "e+" .. word_filters["patterns"]["i"] .. "n+" .. "o+" .. "$"
	},
	["Ruiz"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "r+" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "+" .. "$"
	},
	["Sid(o|a)(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "d+" .. word_filters["patterns"]["ao"] .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Siendo"] = {
		["Class"] = {"-y.-"},
		["Pattern"] = "^" .. word_filters["patterns"]["s"] .. word_filters["patterns"]["i"] .. "e+" .. "n+" .. "d+" .. "o" .. "$"
	},
	["Temi"] = {
		["Class"] = {"-i"},
		["Pattern"] = "^" .. "t+" .. "e+" .. "m+" .. word_filters["patterns"]["i"] .. "$"
	},
	["Ultim(o|a)(s)?"] = {
		["Class"] = {"-i-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["u"] .. "l+" .. "t+" .. word_filters["patterns"]["i"] .. "m+" .. word_filters["patterns"]["ao"] .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Yerno(s)?"] = {
		["Class"] = {"y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "e+" .. "r+" .. "n+" .. "o+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	},
	["Yeso(s)?"] = {
		["Class"] = {"y.-"},
		["Pattern"] = "^" .. "h*" .. word_filters["patterns"]["i"] .. "e+" .. word_filters["patterns"]["s"] .. "o+" .. word_filters["patterns"]["s"] .. "*" .. "$"
	}
}

word_filters.word_match_patterns = {
	["-g-"] = "%w(" .. word_filters["patterns"]["g"] .. ")%w",
	["-i-"] = "%w(" .. word_filters["patterns"]["i"] .. ")%w",
	["-.y-"] = "[aeou](" .. word_filters["patterns"]["i"] .. ")%w",
	["-y.-"] = "%w(" .. word_filters["patterns"]["i"] .. ")[aeo]"
}

word_filters.manual_word_match_patterns = {
	["-g-"] = {
	},
	["-i-"] = {
		["Fuisteis"] = function(word)
			return string.match(word, "^f" .. word_filters["patterns"]["u"] .. "(" .. word_filters["patterns"]["i"] .. ")")
		end,
		["Juicio(s)?"] = function(word)
			return string.match(word, "^" .. word_filters["patterns"]["g"] .. word_filters["patterns"]["u"] .. "(".. word_filters["patterns"]["i"] .. ")")
		end,
		["Hubisteis"] = function(word)
			return string.match(word, "^h" .. word_filters["patterns"]["u"] .. word_filters["patterns"]["b"] .. "(" .. word_filters["patterns"]["i"] .. ")")
		end,
		["Herir(a|e)is"] = function(word)
			return string.match(word, "^her(" .. word_filters["patterns"]["i"] .. ")r")
		end,
		["Hicisteis"] = {
			function(word)
				return string.match(word, "^h(" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. ")" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"])
			end,
			function(word)
				return string.match(word, "^h" .. word_filters["patterns"]["i"] .. word_filters["patterns"]["s"] .. "(" .. word_filters["patterns"]["i"] .. ")" .. word_filters["patterns"]["s"])
			end
		}
	},
	["-.y-"] = {
		["Fuisteis"] = function(word)
			return string.match(word, "e(" .. word_filters["patterns"]["i"] .. ")" .. word_filters["patterns"]["s"] .. "$")
		end
	},
	["-y.-"] = {
	}
}

return word_filters