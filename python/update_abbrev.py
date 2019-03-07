import firebase_admin
from firebase_admin import credentials, db
from firebase_admin import firestore
import json
import pandas as pd
from fuzzywuzzy import fuzz

import re

cred = credentials.Certificate('configs/nutrition-app-flutter-684d31b499fb.json')
keys = open('../assets/config.json').read()
jsonData = json.loads(keys)

firebase_admin.initialize_app(cred, {
    'googleAppID': str(jsonData['googleAppID']),
    'apiKey': str(jsonData['apiKey']),
    'databaseURL': str(jsonData['databaseURL'])
})
#
firestore = firestore.client()

data = open('data/ABBREV.json').read()
parsed_json = json.loads(data)

parsed_keys = {'Total lipid (fat)': ['totalfat', 'g', 55],
               'Carbohydrate, by difference': ['carbohydrate', 'g', 250],
               'Fiber, total dietary': ['fiber', 'g', 27],
               'Cholesterol': ['cholesterol', 'mg', 300],
               'Sugars, total': ['sugar', 'g', 28],
               'Protein': ['protein', 'g', 50],
               'Calcium, Ca': ['calcium', 'mg', 1000],
               'Iron, Fe': ['iron', 'mg', 14.9],
               'Sodium, Na': ['sodium', 'mg', 2300],
               'Energy': ['calorie', 'kcal', 2000],
               'Vitamin A, IU': ['vitamin_a', 'IU', 5000],
               'Vitamin C, total ascorbic acid': ['vitamin_c', 'mg', 70],
               'Fatty acids, total trans': ['trans_fat', 'g', 2],
               'Fatty acids, total saturated': ['saturated_fat', 'g', 30]}

i = 0
c = True
for item in parsed_json['payload']:

    if c:
        print('item: {0}'.format(item))
        d = {}
        n = {}
        cached = []
        d['ndbno'] = item['ndb']
        d['description'] = item['description']
        d['manufacturer'] = item['manufacturer']
        d['ingredients'] = item['ingredients']
        for nutrient in item['nutrients']:
            nutrient['value'] = str(round(float(nutrient['value']), 2)) if nutrient['value'] != 'None' else 0.0

            if nutrient['name'] in parsed_keys:
                # print(nutrient, value)
                cached.append(nutrient['name'])
                n[parsed_keys[nutrient['name']][0]] = {
                    'name': parsed_keys[nutrient['name']][0],
                    'value':  nutrient['value'],
                    'measurement': nutrient['measurement'],
                    'daily': str(round((float(nutrient['value']) / parsed_keys[nutrient['name']][2] * 100), 2))
                }

        for key in parsed_keys.keys():
            if key not in cached:
                n[key] = {
                    'name': key,
                    'value': 0.0,
                    'measurement': parsed_keys[key][1],
                    'daily': 0.0
                }

        d['nutrients'] = n
        d['serving_size'] = item['serving_size']
        d['serving_measurement'] = item['serving_measurement']
        d['serving_size_household'] = item['serving_size_household']
        d['serving_measurement_household'] = str(item['serving_measurement_household']).lower().capitalize()
        print(d, i)
        i += 1

        firestore.collection(u'ABBREV').document().set(d)
        # break
