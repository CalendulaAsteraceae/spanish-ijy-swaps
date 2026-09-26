# Spanish I/J/Y swaps
This code is used to assess I/J/Y swaps in pre-17th century Spanish using data from [CORDE](https://www.rae.es/banco-de-datos/corde), the *Corpus diacrónico del español* of the Real Academia Española, and in particular [the list of frequencies](https://corpus.rae.es/frecuenciasCORDE/listadosFrecuencias.html).

```
require("global_def.lua")
evidence_table_data.print_representative_words()
```

```
require("global_def.lua")
evidence_table_data.print_letter_frequencies()
```

# Data cleaning
### TSV
#### Cleaned forms

Add transcription:

(\n)([^\t]*\t) to $1$2$2

(\n[^\t]*)[áàäãâª] to $1a
(\n[^\t]*)[éèëê] to $1e
(\n[^\t]*)[íìïî] to $1i
(\n[^\t]*)[óòöõôøº] to $1o
(\n[^\t]*)[úùüû] to $1u
(\n[^\t]*)ç to $1c
(\n[^\t]*)ñ to $1n
(\n[^\t]*)ý to $1y
(\n[^\t]*)æ to $1ae
(\n[^\t]*)\+ to $1

Check \n[^\t]*[^\t \w]+

#### Period forms

Transcripción   Forma	Total	–1200	1201–1250	1251–1300	1301–1350	1351–1400	1401–1450	1451–1500	1501–1550	1551–1600

(\n[^\t]*\t[^\t]*\t)\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t to $1$2

Delete \n[^\t]*\t[^\t]*\t0\t0\t0\t0\t0\t0\t0\t0\t0

#### Contains I/J/Y

Delete \n[^\tijy]*\t[^\t]*[\t\d]+

### Lua

([^\t]*)\t([^\t]*)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)(\n)
to
\t{["Transcripción"] = "$1", ["Forma"] = "$2", ["Datos"] = {$3, $4, $5, $6, $7, $8, $9, $10, $11}},$12