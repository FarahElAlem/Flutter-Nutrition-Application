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

data = open('data/RECIPES2.json').read()
parsed_json = json.loads(data)

for item in parsed_json:
    print(item)
    firestore.collection(u'RECIPES').document().set(item)

#
# cur = []
# new = []
# for item in parsed_json:
#     if item['name'] not in cur:
#         cur.append(item['name'])
#         new.append(item)
#     else:
#         print('{0} duped'.format(item['name']))

#
# docs = firestore.collection(u'RECIPES').get()
# cur = []
# new = []
#
# for doc in docs:
#     d = doc.to_dict()
#     if d['name'] not in cur:
#         cur.append(d['name'])
#         new.append(d)
#     else:
#         print('{0} duped'.format(d['name']))
#
#
# with open('data/RECIPES2.json', 'w') as outfile:
#     json.dump(new, outfile)