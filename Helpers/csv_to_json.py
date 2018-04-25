import csv
import json

file = open('../csv_data/age_p.csv')

data_iter = csv.reader(file)

data = []

for row in data_iter:

    data.append(float(row[0]))

# print(len(data))
jsoned = json.dumps(data)

wri_file = open('./age_p.js', 'w')

wri_file.write('AgeP30K=')

wri_file.write(jsoned)

# print(jsoned)