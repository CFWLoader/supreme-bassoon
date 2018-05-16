import statsmodels.api as statmod
import pandas
# import statsmodels.tsa._expsmoothings as esfamily

seasfac_data = pandas.read_csv('../../../va_data/catalog_seasfac_cus.csv', usecols=['men'])

# arma01mod = statmod.tsa.ARMA(seasfac_data, (0,1)).fit(disp = False)

# arma10mod = statmod.tsa.ARMA(seasfac_data, (1,0)).fit(disp = False)

sesMod = statmod.tsa.SimpleExpSmoothing(seasfac_data).fit()

print(sesMod.params)

# print(arma01mod.params)

# print(arma10mod.params)

# print(seasfac_data)

# statmod.tsa.ARMA()