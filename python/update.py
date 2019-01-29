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

data = open('data/ABBREV.json').read()
parsed_json = json.loads(data)

for item in parsed_json:
    item['calories'] = item['calories'] = round(
        float(item['Carbohydrt_(g)']) * 4 + float(item['Protein_(g)']) * 4 + float(
            item['Lipid_Tot_(g)']) * 9)
    firestore.collection(u'ABBREV').document().set(item)
