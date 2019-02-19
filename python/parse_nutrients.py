import pandas as pd
import re
import json


def format_name(s):
    exceptions = ['and', 'or', 'an']
    tokens = str(s).split(' ')
    tokens = [str(x).lower().capitalize() if x not in exceptions else x for x in tokens]
    return str(' '.join(tokens))


def parse_ingredients(ingredients):
    ingredients = re.sub(r'\([^)]*\)', '', ingredients)
    ingredients = str(ingredients).replace('(', '')
    ingredients = str(ingredients).replace(')', '')
    return list(set([x.strip() for x in str(ingredients).split(',')]))

print('Started Loading')
df_nutr = pd.read_excel('data/Nutrient.xlsx', converters={'NDB_No': lambda x: str(x)})
df_prod = pd.read_excel('data/Products.xlsx', converters={'NDB_Number': lambda x: str(x)})
df_serv = pd.read_excel('data/Serving_Size.xlsx', converters={'NDB_No': lambda x: str(x)})

df_prod['long_name'] = [format_name(x) for x in df_prod['long_name']]
df_prod['manufacturer'] = [format_name(x) for x in df_prod['manufacturer']]
df_prod['ingredients_english'] = [format_name(x) for x in df_prod['ingredients_english']]

nutr_ndb = list(df_nutr['NDB_No'])
serv_ndb = list(df_serv['NDB_No'])

ABBREV = []

i = 1
print('Finished Loading')
print('Started Parsing')
for index, row in df_prod.iterrows():
    if row['NDB_Number'] in nutr_ndb and row['NDB_Number'] in serv_ndb:
        nutr = df_nutr.loc[df_nutr['NDB_No'] == row['NDB_Number']]
        serv = df_serv.loc[df_serv['NDB_No'] == row['NDB_Number']]

        kingredients = row['ingredients_english']
        kingredients = parse_ingredients(kingredients)

        serving_size = float(serv['Serving_Size'].values[0])
        serving_measement = str(serv['Serving_Size_UOM'].values[0])

        knutrients = []
        knutrientsNames = []
        for index2, row2 in nutr.iterrows():
            value = None
            if serving_measement == 'g':
                value = float(row2['Output_value']) * (serving_size / 100.0)
            elif serving_measement == 'mg':
                value = float(row2['Output_value']) * (serving_size / 1000.0)
            knutrientsNames.append(str(row2['Nutrient_name']))
            knutrients.append({
                'name': str(row2['Nutrient_name']),
                'value': str(value),
                'measurement': str(row2['Output_uom'])
            })

        print(knutrients)

        kdict = {
            'ndb': str(row['NDB_Number']),
            'description': str(row['long_name']),
            'manufacturer': str(row['manufacturer']),
            'ingredients': list(kingredients),
            'nutrients': list(knutrients),
            'serving_size': str(serv['Serving_Size'].values[0]),
            'serving_measurement': str(serv['Serving_Size_UOM'].values[0]),
            'serving_size_household': str(serv['Household_Serving_Size'].values[0]),
            'serving_measurement_household': str(serv['Household_Serving_Size_UOM'].values[0])
        }
        print(kdict['description'], i)
        i += 1
        ABBREV.append(kdict)

# print(ABBREV)
out = {'payload': ABBREV}
with open('data/ABBREV.json', 'w') as outfile:
    json.dump(out, outfile)

print('Finished Parsing')
