import json
import re


def parse_ingredient(ingredient, abvr):
    tokens = ingredient.split(' ')
    numeric = None
    abv = None
    other = None
    rest = []
    for i in range(len(tokens)):
        if i == 0 and str(tokens[i][0]).isnumeric():
            numeric = tokens[0]
        for j in range(0, len(tokens)):
            if tokens[j] in abvr:
                abv = tokens[j]
            elif numeric is None:
                rest.append(tokens[j])
            elif numeric is not None and j > 0:
                rest.append(tokens[j])
        break

    if numeric is None:
        numeric = ''
    if abv is None and numeric is None:
        abv = 'to taste'
    elif abv is None and numeric is not None:
        abv = ''

    rest = ' '.join(rest)
    st = rest
    if rest.find(',') != -1:
        st = rest[0:rest.find(',')]
        other = rest[rest.find(',')+1:]
    elif rest.find('(') != -1:
        st = rest[0:rest.find('(')]
        other = rest[rest.find('(')+1:]
    else:
        other = ''

    print(ingredient)
    print('numeric: {0} \ abv: {1} \ rest: {2} \ other: {3}'.format(numeric, abv, st, other), end='\n\n')

    return {'value': numeric,
            'abv': abv,
            'str': st,
            'other': other.strip()}


def replace_ingredients(ingredients, actions, abvr):
    new_ingredients = []

    for ingredient in ingredients:
        # print(ingredient)
        # ingredient = re.sub(r'\W+', ' ', ingredient)
        tokens = ingredient.split(' ')
        for token in tokens:
            if token in actions.keys():
                ingredient = ingredient.replace(token, actions[token])
        parsed = parse_ingredient(ingredient, abvr)
        new_ingredients.append({'ingredient': ingredient, 'details': parsed})
    return new_ingredients


f = open('data/RECIPES.json')
dat = json.loads(f.read())

abvr = ['tsp.', 'tbsp.', 'cloves', 'clove', 'lb.', 'cup', 'cups', 'tablespoon', 'bundle', 'box', 'bulb', 'stick',
        'sticks']

actions = {'tablespoon': 'tbsp.',
           'tbs': 'tbsp.',
           'tablespoons': 'tbsp.',
           'teaspoons': 'tsp.',
           'teaspoon': 'tsp.',
           'tbsp': 'tsp.',
           'tsp': 'tsp.',
           'pound': 'lb.',
           'ounce': 'oz.',
           'ounces': 'oz.',
           'oz': 'oz.',
           'lb': 'lb.',
           '⅓': '1/3',
           '½': '1/2',
           '⅔': '2/3',
           '¾': '3/4',
           '¼': '1/4',
           }

new = []
for item in dat:
    item['ingredients'] = replace_ingredients(item['ingredients'], actions, abvr)
    print(item['ingredients'])
    new.append(item)
    print(new)

with open('data/RECIPES2.json', 'w') as outfile:
    json.dump(new, outfile)
