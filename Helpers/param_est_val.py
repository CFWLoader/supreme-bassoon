import csv
import scipy.stats as stats

file = open('../csv_data/age_p.csv')

data_iter = csv.reader(file)

data = []

# next(data_iter)     # Skip header.

for row in data_iter:

    # print(float(row[0]))
    data.append(float(row[0]))

# print(len(data))

a, loc, b = stats.gamma.fit(data, floc = 0)

print(a)

print(1 / b)

result = stats.exponweib.fit(data, floc = 0, f0 = 1)

print(result)

# betaRep = scipy.stats.beta.fit(data, floc = 0, fscale = 1)

# print(betaRep)