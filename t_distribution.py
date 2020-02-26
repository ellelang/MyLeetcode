import numpy as np
import math 
import matplotlib.pyplot as plt
plt.style.use("seaborn")
import seaborn as sns
from scipy.stats import t

"""Generate t distributed values"""
def f(x, mu):
    n = len(x)
    return np.sqrt(n) * (x.mean()-mu)/ x.std()

mu = 0
df = 3


for i in range(5):
    plt.subplot(2,5,i+1)
    t_vals = [f(np.random.normal(loc = mu, size = df + 1), mu) for i in range(10000)]
    sns.distplot(t_vals, kde = False, norm_hist = True)
    x = np.linspace(-5, 5, 100)
    plt.plot(x, t.pdf(x, df))
    plt.xlim([-5, 5])
    plt.xlabel(r"$x$")
    if i == 0:
        plt.ylabel(r"$p(x)$")
    if i == 2:
        plt.title("Manually generated")

for i in range(5):
    plt.subplot(2,5,i+6)
    t_vals = np.random.standard_t(df, size = 10000)
    sns.distplot(t_vals, kde = False, norm_hist = True)
    x = np.linspace(-5, 5, 100)
    plt.plot(x, t.pdf(x, df))
    plt.xlim([-5, 5])
    plt.xlabel(r"$x$")
    if i == 0:
        plt.ylabel(r"$p(x)$")
    if i == 2:
        plt.title("Generated using python")

plt.tight_layout()
plt.savefig("t_dists.pdf", bboxinches = "tight")


from math import e
e**(0.59)
e**(0.1563)
e**(-0.8) 
1-e**(-0.014*60)
math.ln(0.09)
