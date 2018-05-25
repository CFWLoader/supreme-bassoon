import statsmodels.api as statmod
import pandas
import os
import json

script_dir = os.path.dirname(__file__)

file_loc = os.path.join(script_dir, "..", "..", "va_data", "catalog_seasfac_cus.csv")

seasfac_data = pandas.read_csv(file_loc)

jsoned =  json.dumps(seasfac_data["print"].values.tolist())

wri_file = open('./cata_print.json', 'w')

wri_file.write('printData=')

wri_file.write(jsoned)

wri_file.close()

# print(jsoned)