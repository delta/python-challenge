import random
import string

totalLen = 10

def runlen():
    l = string.ascii_letters
    ques = ""
    ans = ""
    for i in range(totalLen):
        n = random.randint(1, 100)
        c = l[random.randint(0, len(l) - 1)]
        ques += f"{n}{c}"
        ans += c * n
    print(ques)
    print(ans)

runlen()
