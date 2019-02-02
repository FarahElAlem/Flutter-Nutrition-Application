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

key_items = ['Lipid_Tot_(g)', 'Carbohydrt_(g)', 'Fiber_TD_(g)', 'Cholestrl_(mg)', 'Sugar_Tot_(g)', 'Protein_(g)',
             'Vit_D_µg', 'Calcium_(mg)', 'Iron_(mg)', 'Potassium_(mg)', 'Shrt_Desc', 'NDB_No', 'Energ_Kcal', 'Fd_Grp',
             'Sodium_(mg)']

parsed_keys = {'Lipid_Tot_(g)': 'lipid', 'Carbohydrt_(g)': 'carbohydrate', 'Fiber_TD_(g)': 'fiber',
               'Cholestrl_(mg)': 'cholesterol', 'Sugar_Tot_(g)': 'sugar',
               'Protein_(g)': 'protein', 'Vit_D_µg': 'vitamind', 'Calcium_(mg)': 'calcium', 'Iron_(mg)': 'iron',
               'Potassium_(mg)': 'potassium', 'NDB_No': 'ndbno', 'Shrt_Desc': 'description', 'Energ_Kcal': 'calorie',
               'Fd_Grp': 'foodgroup', 'Sodium_(mg)': 'sodium'}

for item in parsed_json:
    altered = {}
    for key in item.keys():
        if key in key_items:
            altered[parsed_keys[key]] = item[key]
    altered['calorie'] = str(float(altered['calorie']) / 1000)
    altered['ndbno'] = int(round(float(altered['ndbno'])))
    print(altered)
    # firestore.collection(u'ABBREV').document().set(altered)
