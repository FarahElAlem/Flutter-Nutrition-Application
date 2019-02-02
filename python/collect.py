import json
from bs4 import BeautifulSoup
import requests

_categories = {'http://recipes.wikia.com': {'Standard,Main Dishes': '/wiki/Category:Main_Dish_Recipes',
                                            'Standard,Appetizers': '/wiki/Category:Appetizer_Recipes',
                                            'Standard,Side Dishes': '/wiki/Category:Side_Dish_Recipes',
                                            'Standard,Beverages': '/wiki/Category:Beverage_Recipes'},
               'http://healthyrecipes.wikia.com': {'Healthy,Main Dishes': '/wiki/Category:Main_Dish_Recipes',
                                                   'Healthy,Appetizers': '/wiki/Category:Appetizer_Recipes',
                                                   'Healthy,Side Dishes': '/wiki/Category:Side_Dish_Recipes',
                                                   'Healthy,Beverages': '/wiki/Category:Beverage_Recipes',
                                                   'Healthy,Gluten Free': 'Category:Gluten_Free_Recipes'},
               'http://desserts.wikia.com': {'Desserts,Cakes': '/wiki/Category:Cake_Recipes',
                                             'Desserts,Cheesecakes': '/wiki/Category:Cheesecake_Recipes',
                                             'Desserts,Pies': '/wiki/Category:Pie_Recipes',
                                             'Desserts,Desserts': '/wiki/Category:Pastry_Recipes',
                                             'Desserts,Gluten Free': '/wiki/Category:Cookie_Recipes'},
               }
_recipes = []
_baseurls = ['http://recipes.wikia.com', 'http://healthyrecipes.wikia.com', 'http://desserts.wikia.com']

for base in _baseurls:
    categ = _categories[base]
    for category in categ:
        url = base + categ[list(categ.keys())[0]]
        print(url)
        response = requests.get(url, timeout=5)
        content = BeautifulSoup(response.content, 'html.parser')
        div = content.find_all('li', attrs={'class': 'category-page__member'})
        for li in div:
            try:
                href = li.find('a')['href']
                itemUrl = base + href
                _response = requests.get(itemUrl, timeout=5)
                _content = BeautifulSoup(_response.content, 'html.parser')
                img = _content.find('img', attrs={'data-image-key': True, 'data-image-name': True})
                description = _content.find('span', attrs={'id': 'Description'}).parent.find_next_sibling()
                if img is not None and description.name == 'p' and 'contributed' not in description.text.lower():
                    print(li.find('a').text.strip())
                    name = _content.find('h1', attrs={'class': 'page-header__title'}).text
                    imgUrl = img['src']
                    ul = _content.find('span', attrs={'id': 'Ingredients'}).parent.find_next('ul').find_all('li')
                    ingredients = []
                    directions = []
                    for _li in ul:
                        ingredients.append(_li.text.strip())
                    ol = _content.find('span', attrs={'id': 'Directions'}).parent.find_next('ol').find_all('li')
                    for _li in ol:
                        directions.append(_li.text.strip())
                    _tokens = str(list(categ.keys())[0]).split(',')
                    _recipe = {
                        'name': name,
                        'image': imgUrl,
                        'description': description.text.strip().replace('\xa0', ''),
                        'ingredients': ingredients,
                        'directions': directions,
                        'category': _tokens[0],
                        'subcategory': _tokens[1]
                    }
                    _recipes.append(_recipe)
            except Exception:
                pass

with open('../data/RECIPES.json', 'w') as outfile:
    json.dump(_recipes, outfile)
