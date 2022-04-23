from bs4 import BeautifulSoup
from base64 import b64encode
import random
import string

with open('chall.html', 'r') as f:
    html = f.read()

rating_ids = [''.join(random.choices(string.ascii_letters + string.digits, k=5)) for _ in range(100)]
base64_array = []

for i in range(100):
    soup = BeautifulSoup(html, 'html.parser')
    rating_tag = soup.find_all('input', {'name': 'rating'})
    rating_tag[0]['id'] = rating_ids[i]
    
    with open(f'pages/chall_{i+1}.html', 'w+') as f:
        f.write(soup.prettify())
        base64_content = b64encode(soup.prettify().encode('utf-8')).decode()
        base64_array.append(base64_content)


flag = ''.join(s for s in rating_ids)

with open('flag.txt', 'w') as f:
    f.write(flag)

with open('webscrape/chall.py', 'w') as f:
    f.write(f'html_files_in_base64 = {base64_array}\n')
