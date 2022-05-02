def yYteIlVNRB(n):
    if n == 2:
        return True
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i = i + 1
    return True

from random import randrange

pydELcZCrr = []

while len(pydELcZCrr) < 1000:
    x = randrange(1000, 10000)
    if not yYteIlVNRB(x):
        pydELcZCrr.append(x)

wQIBJQgwcR = randrange(0, 1000)
numlist = pydELcZCrr[:wQIBJQgwcR] + [7331] + pydELcZCrr[wQIBJQgwcR:]
