import statsmodels.api as statmod
import pandas
import os
# import statsmodels.tsa._expsmoothings as esfamily

script_dir = os.path.dirname(__file__)

file_loc = os.path.join(script_dir, "..", "..", "..", "va_data", "catalog_seasfac_cus.csv")

seasfac_data = pandas.read_csv(file_loc, usecols=['men'])

# arma01mod = statmod.tsa.ARMA(seasfac_data, (0,1)).fit(disp = False)

# arma10mod = statmod.tsa.ARMA(seasfac_data, (1,0)).fit(disp = False)

sesMod = statmod.tsa.SimpleExpSmoothing(seasfac_data).fit()

print(sesMod.params)

# print(arma01mod.params)

# print(arma10mod.params)

# print(seasfac_data)

# statmod.tsa.ARMA()