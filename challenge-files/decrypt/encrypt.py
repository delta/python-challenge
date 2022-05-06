from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from base64 import b64encode

key = b'nAUFVZ9JLZ2HXhrf'
iv = b'c=d;5q>bWA{zJ~SX'
data = b'Delta is a state of mind'
cipher = Cipher(algorithms.SEED(key), modes.OFB(iv))
encryptor = cipher.encryptor()
ct = encryptor.update(data) + encryptor.finalize()
ct = b64encode(ct).decode()
print(ct)
