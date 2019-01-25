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

root = firebase_admin.db.reference()
ABBREV = root.child('ABBREV').get()
FOODDESC = root.child('FOODDESC').get()
FOODGROUP = root.child('FOODGROUP').get()
NUTRDESC = root.child('NUTRDESC').get()
RECIPES = root.child('RECIPES').get()


for a in list(ABBREV):
    key = a['Shrt_Desc'].replace('/', '')
    print(key)
    firestore.collection(u'ABBREV').document().set(a)

for a in list(FOODGROUP):
    key = a['FdGrp_Desc'].replace('/', '')
    print(key)
    firestore.collection(u'FOODGROUP').document().set(a)

for a in list(NUTRDESC):
    key = str(a['Tagname']).replace('/', '')
    print('key: {0}'.format(key))
    if key != '':
        firestore.collection(u'NUTRDESC').document().set(a)

for a in list(RECIPES):
    key = a['name'].replace('/', '')
    print(key)
    firestore.collection(u'RECIPES').document().set(a)
