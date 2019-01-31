from bs4 import BeautifulSoup
import requests

_categories = {'http://recipes.wikia.com': {{'Main Dish': '/wiki/Category:Main_Dish_Recipes'},
                                            {'Appetizer': '/wiki/Category:Appetizer_Recipes'},
                                            {'Side Dish': '/wiki/Category:Side_Dish_Recipes'},
                                            {'Dessert': '/wiki/Category:Dessert_Recipes'},
                                            {'Beverages': '/wiki/Category:Beverage_Recipes'}}}
_baseurl = 'http://recipes.wikia.com'

_links = []
_recipes = []
for category in _categories:
    url = _baseurl + category[list(category.keys())[0]]
    response = requests.get(url, timeout=5)
    content = BeautifulSoup(response.content, 'html.parser')
    div = content.find_all('li', attrs={'class': 'category-page__member'})
    for li in div:
        try:
            href = li.find('a')['href']
            itemUrl = _baseurl + href
            _response = requests.get(itemUrl, timeout=5)
            _content = BeautifulSoup(_response.content, 'html.parser')
            img = _content.find('img', attrs={'data-image-key': True, 'data-image-name': True})
            description = _content.find('span', attrs={'id': 'Description'}).parent.find_next_sibling()
            if img is not None and description.name == 'p' and 'contributed' not in description.text:
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
                _recipe = {
                    'name': name,
                    'image': imgUrl,
                    'description': description.text.strip().replace('\xa0', ''),
                    'ingredients': ingredients,
                    'directions': directions,
                    'category': list(category.keys())[0]
                }
                _recipes.append(_recipe)
        except Exception:
            pass

_baseurls = ['http://recipes.wikia.com', 'http://healthyrecipes.wikia.com', 'http://desserts.wikia.com',
             'http://japaneserecipes.wikia.com', 'http://glutenfreerecipes.wikia.com']
