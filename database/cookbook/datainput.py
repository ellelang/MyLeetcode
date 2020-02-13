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
