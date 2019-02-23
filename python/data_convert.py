import firebase_admin
from firebase_admin import credentials, db
from firebase_admin import firestore
import json

cred = credentials.Certificate('configs/nutrition-app-flutter-684d31b499fb.json')
keys = open('../assets/config.json').read()
jsonData = json.loads(keys)

firebase_admin.initialize_app(cred, {
    'googleAppID': str(jsonData['googleAppID']),
    'apiKey': str(jsonData['apiKey']),
    'databaseURL': str(jsonData['databaseURL'])
})

firestore = firestore.client()

docs = firestore.collection(u'RECIPES').get()

out = []
for doc in docs:
    d = doc.to_dict()
    temp = {}
    temp['title'] = d['name'].strip()
    temp['subtitle'] = d['category'].strip()
    temp['leading'] = d['image'].strip()
    out.append(temp)

# f1 = open('data/RECIPES_NAMES.txt')
# l1 = f1.readlines()
#
# f2 = open('data/RECIPES_CATEG.txt')
# l2 = f2.readlines()

# out = []
# for i in range(len(l1)):
#     temp = {}
#     temp['title'] = l1[i].strip()
#     temp['subtitle'] = l2[i].strip()
#     out.append(temp)
#
d = {}
d['payload'] = out

f3 = open('data/ABBREV_SEARCH.json', 'w')
json.dump(d, f3)
