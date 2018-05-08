'''
Extract seasonal decomposition arguments from csv file and save as json.
'''
import csv
import json
import os

script_dir = os.path.dirname(__file__)

file_loc =  os.path.join(script_dir, "..", "..", "va_data", "catalog_seasfac_cus.csv")

file_obj = open(file_loc)

csv_obj = csv.reader(file_obj)

trend_cycle = []

seasonal = []

irregular = []

next(csv_obj)

for line in csv_obj:

    trend_cycle.append(float(line[19]))

    seasonal.append(float(line[18]))

    irregular.append(float(line[16]))

file_obj.close()

timeSeriesDecomposition = {"trend_cycle" : trend_cycle, "seasonal" : seasonal, "irregular" : irregular}

json_obj = json.dumps(timeSeriesDecomposition)

file_obj = open(os.path.join(script_dir, "women.json"), "w")

file_obj.write(json_obj)

file_obj.close()