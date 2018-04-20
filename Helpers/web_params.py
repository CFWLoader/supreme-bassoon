import scipy.stats as stats
import csv

file = open('../../csv_data/AQI.csv')

data_iter = csv.reader(file)

data = []

next(data_iter)     # Skip header.

for row in data_iter:

    data.append(float(row[0]))

# print(len(data))

result = stats.exponweib.fit(data, floc = 0, f0 = 1)

print(result)