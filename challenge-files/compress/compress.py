import random
import zipfile
import tarfile
import os
import shutil

totalFiles = 100
totalLayers = 10

def compress(filename, isWrong, ind, isFirst, cur):
    match ind:
        case 0:
            with zipfile.ZipFile(f"{filename}.zip", "w") as f:
                if isWrong:
                    f.write("wrong.txt")
                else:
                    if isFirst:
                        f.write("flag.txt")
                    else:
                        for file in os.listdir(f"./{cur - 1}"):
                            full = os.path.join(f"./{cur - 1}", file)
                            f.write(full)

                        shutil.rmtree(f"{cur - 1}")
        case 1:
            with tarfile.open(f"{filename}.tar", "w:gz") as f:
                if isWrong:
                    f.add("wrong.txt")
                else:
                    if isFirst:
                        f.add("flag.txt")
                    else:
                        for file in os.listdir(f"./{cur - 1}"):
                            full = os.path.join(f"./{cur - 1}", file)
                            f.add(full)

                        shutil.rmtree(f"{cur - 1}")

def create():
    for i in range(totalLayers):
        ind = random.randint(0, 1)
        correct = random.randint(1, totalFiles)
        os.mkdir(f"{i + 1}")
        with open(f"./{i + 1}/correct.txt", "w") as f:
            f.write(f"The correct one is {correct}")
        for j in range(totalFiles):
            if j + 1 == correct:
                compress(f"./{i + 1}/{j + 1}", False, ind, i == 0, i + 1)
                continue
            compress(f"./{i + 1}/{j + 1}", True, ind, True, i + 1)
    with zipfile.ZipFile(f"final.zip", "w") as f:
        for file in os.listdir(f"./{totalLayers}"):
            full = os.path.join(f"./{totalLayers}", file)
            f.write(full)
    shutil.rmtree(f"{totalLayers}")
create()
