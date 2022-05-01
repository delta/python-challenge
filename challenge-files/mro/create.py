import string
import random

# Solution can be concatenation of all the class names, or them hashed together?
def create(n):
    cur = ""
    res = ""
    for _ in range(n):
        c = "".join(random.sample(string.ascii_letters, 10))
        res += f"""class {c}({cur}):
    pass\n"""
        cur = c
    with open("final.py", "w") as f:
        f.write(res)

create(1000)
