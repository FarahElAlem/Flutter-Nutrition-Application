import json
from fuzzywuzzy import fuzz


def parse_serving(s):
    tokens = str(s)
    sloc = -1
    eloc = -1
    for i in range(len(tokens)):
        if i > 0 and tokens[i-1] == ' ' and tokens[i] != ' ':
            sloc = i
        if tokens[i:i+4] == 'Name' and i < len(tokens)-5:
            eloc = i
            break
    print('YES: {0}'.format(s[sloc:eloc]))
    return s[sloc:eloc].strip()




# 100gram to measure
# Divide by this to get one [key], then mult
converter = {'tsp.': '23.471055307539',
             'tbsp.': '7.8236851025131005',
             'lb.': '0.220462',
             'cup': '0.526315',
             'cups': '0.526315'}

f = open('data/RECIPES2.json')
dat = json.loads(f.read())

f2 = open('data/ABBREV.json')
data = json.loads(f2.read())['payload']

ABBREV = {}
KEYS = [x['description'] for x in data]
# for x in data:
#     dat = x
#     print(x['serving_size'], x['serving_measurement'])
#     print(parse_serving(x['serving_size']))
#     print(parse_serving(x['serving_measurement']))

# out = {'payload': ABBREV}
# with open('data/ABBREV.json', 'w') as outfile:
#     json.dump(out, outfile)

print(len(KEYS))
for item in dat:
    nutrients = {}
    ingredients = item['ingredients']
    for ingredient in ingredients:
        print(ingredient['details']['str'])
        tempStrge = []
        for name in KEYS:
            # print('{0} v.s. {1} : {2}%'.format(ingredient['details']['str'], name, fuzz.ratio(ingredient['details']['str'], name)))
            ratio = fuzz.ratio(ingredient['details']['str'], name)
            if ratio >= 45:
                tempStrge.append((name, ratio))
        tempStrge.sort(key=lambda tup: tup[1], reverse=True)
        max = tempStrge[0]
        print(tempStrge)

