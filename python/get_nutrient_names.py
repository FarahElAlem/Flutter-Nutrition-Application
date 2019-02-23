import json
import re

data = open('data/ABBREV.json', encoding='utf-8').read()
parsed_json = json.loads(data)

names = []
for item in parsed_json['payload']:
        names.append(re.sub(r'[^\x00-\x7F]+',' ', item['manufacturer']) + "\n")

with open('data/ABBREV_MANUF.txt', 'w') as outfile:
    outfile.writelines(names)

