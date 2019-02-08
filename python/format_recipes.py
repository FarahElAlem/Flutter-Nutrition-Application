import pandas as pd
import json
import requests
from urllib.parse import quote

nutrients = ['Total lipid (fat)', 'Carbohydrate, by difference', 'Fiber, total dietary', 'Cholesterol', 'Sugars, total',
             'Protein', 'Vitamin D (D2 + D3)', 'Calcium, Ca', 'Iron, Fe', 'Potassium, K']

removable_tokens = ['and', 'peeled', 'chopped', 'cup', 'tablespoon', 'teaspoon', 'deveined', 'uncooked', 'medium',
                    'small', 'large', 'pound', 'tablespoons', 'to', 'taste', 'fresh', 'or', 'frozen', ',', 'with',
                    'the', 'ends', 'trimmed', 'lb.', '½', '¼', 'canned', 'cup', 'sliced', 'diagonally', 'low',
                    'low-sodium', 'sodium', 'tsp.', 'lukewarm', 'regular', 'only', 'cups', 'boneless', 'kilo', 'kilos',
                    'sliced', 'or', 'defrosted', 'shredded', '⅔', 'or', 'red', 'white', 'yellow', 'piece', 'eye',
                    'bird\'s', 'bottle', 'in', 'drained', 'gram', 'grams', 'cooked', 'according', 'package',
                    'directions', 'cooled', '⅓', 'dark', 'light', ' ', 'for', 'garnishing', 'if', 'desired',
                    'reserving', 'Barbados', 'grated', 'orange', 'peel', 'oz.', 'teaspoons', 'pounds', 'qt.', 'stewing',
                    'bones', 'lb', 'cubed', 'sprig', 'stalks', 'g.', 'thread', 'coarsely', 'tbsp.']


def search(nutrient, key):
    print(nutrient)
    nutrient = ''.join([i for i in nutrient if not i.isdigit()]).replace('\xa0', ' ').replace(',', '').replace('-', ' ')
    if '(' in nutrient:
        nutrient = nutrient[0:nutrient.index('(')] + nutrient[nutrient.index(')') + 1:]
    n = nutrient.split(' ')
    print('\t\t' + str(n))
    no = []
    for string in n:
        if string not in removable_tokens:
            no.append(string)
    query = ' '.join(no)
    print('\t' + query)
    url = 'https://api.nal.usda.gov/ndb/search/?format=json&q={0}&max=4&offset=0&api_key={1}&sort=r&ds={2}'.format(
        quote(query),
        key,
        quote('Branded Food Products'))
    print(url)
    response = requests.get(url, timeout=5)
    j = json.loads(response.content)
    return report(j['list']['item'][0]['ndbno'], key)


def report(ndbo_number, key):
    url = 'https://api.nal.usda.gov/ndb/reports/?ndbno={0}&type=f&format=json&api_key={1}'.format(
        ndbo_number,
        key)
    response = requests.get(url, timeout=5)
    j = json.loads(response.content)
    nutr_list = {}

    for nutrient in j['report']['food']['nutrients']:
        if nutrient['name'] in nutrients:
            nutr_list[nutrient['name']] = nutrient['value']
    return nutr_list


f = open('configs/ndba.json')
obj = json.loads(f.read())
apiKey = obj['key']
f.close()

f2 = open('data/RECIPES.json')
obj = json.loads(f2.read())

for i in range(len(obj)):
    print('{0} / {1}'.format(i, len(obj)))
    row = obj[i]
    item_tot = {
        'Total lipid (fat)': 0,
        'Carbohydrate, by difference': 0,
        'Fiber, total dietary': 0,
        'Cholesterol': 0,
        'Sugars, total': 0,
        'Protein': 0,
        'Vitamin D (D2 + D3)': 0,
        'Calcium, Ca': 0,
        'Iron, Fe': 0,
        'Potassium, K': 0
    }
    for ingredient in row['ingredients']:
        item_dict = search(ingredient, apiKey)
        for key in item_tot.keys():
            item_tot[key] = float(item_tot[key] if key in item_tot.keys() is not None else 0) + float(
                item_dict[key] if key in item_dict.keys() is not None else 0)
    item_tot['Calories'] = (item_tot['Carbohydrate, by difference'] - item_tot['Fiber, total dietary']) * 4 + (
        item_tot['Total lipid (fat)']) * 9 + (item_tot['Protein']) * 4

    for item in item_tot.keys():
        item_tot[item] = str(round(item_tot[item], 2))

    obj[i]['nutrients'] = item_tot
    print(obj[i])
