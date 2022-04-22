from PIL import Image

sp = 60

def split():
    with Image.open("./python.png") as im:
        im_w = im.width / sp
        im_h = im.height / sp
        for i in range(sp):
            for j in range(sp):
                im_crop = im.crop((im_w * i, im_h * j, im_w * (i + 1), im_h * (j + 1)))
                im_crop.save(f"{i + 1}_{j + 1}.png")

def join():
    with Image.open("./1_1.png") as im:
        x = im.width
        y = im.height
    image = Image.new("RGB", (x * sp, y * sp))
    for i in range(sp):
        for j in range(sp):
            offset = x * i, x * j
            with Image.open(f"{i + 1}_{j+1}.png") as im:
                image.paste(im, (x * i, y * j, x * (i + 1), y * (j + 1)))
    image.save("correct.png")

# split()
join()
