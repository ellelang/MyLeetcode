import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from pathlib import Path
data_folder = Path('C:/Users/langzx/Desktop/tables')
state = pd.read_csv(data_folder/"states.txt",sep='\t',header = None)
state.head(4)
state.columns = ['State','SH','Date','Record']
state['State'] = state['State'].apply(lambda x: "('" + str(x) + "'")
state['SH'] = state['SH'].apply(lambda x: "'" + str(x) + "'")
state['Date'] = state['Date'].apply(lambda x: "'" + str(x) + "'")
state['Record'] = state['Record'].apply(lambda x: str(x) + ")")	
state.to_csv(data_folder/'stateinput.txt',sep=',', index=False, header=False)


tax = pd.read_csv(data_folder/"sales_tax_rate.txt",sep='\t',header = None)
tax.head()
tax.columns = ['State','Rate']
tax['State'] = tax['State'].apply(lambda x: "('" + str(x) + "'")
tax['Rate'] = tax['Rate'].apply(lambda x: str(x) + ")")	
tax.to_csv(data_folder/'taxinput.txt',sep=',', index=False, header=False)


city = pd.read_csv(data_folder/"city.txt",sep='\t',header = None)
city.head()
city.columns = ['State','Capital','Center']
city['State'] = city['State'].apply(lambda x: "('" + str(x) + "'")
city['Capital'] = city['Capital'].apply(lambda x: "'" + str(x) + "'")
city['Center'] = city['Center'].apply(lambda x: "'" + str(x) + "')")
city.to_csv(data_folder/'cityinput.txt',sep=',', index=False, header=False)

winter = pd.read_csv(data_folder/"al_winner-2001.txt",sep='\t',header = None)
winter.head()
winter.columns = ['State','Degree']
winter['State'] = winter['State'].apply(lambda x: "'" + str(x) + "'")
winter['Degree'] = winter['Degree'].apply(lambda x: str(x) + ")")	
winter.to_csv(data_folder/'winterinput.txt',sep=',', index=False, header=False)
