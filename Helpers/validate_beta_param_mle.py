import csv
import scipy.stats

file = open('../../csv_data/BetaSynData5K.csv')

data_iter = csv.reader(file)

data = []

next(data_iter)     # Skip header.

for row in data_iter:

    # print(float(row[0]))
    data.append(float(row[0]))

betaRep = scipy.stats.beta.fit(data, floc = 0, fscale = 1)

print(betaRep)