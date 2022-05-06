from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from base64 import b64decode

key = b'nAUFVZ9JLZ2HXhrf'
iv = b'c=d;5q>bWA{zJ~SX'
cipher_text_in_base64 = "Ebse8E1AF/9LwxaYySb8To5Yl6SpEQ5+"
cipher_text = b64decode(cipher_text_in_base64)
cipher = Cipher(algorithms.SEED(key), modes.OFB(iv))
decryptor = cipher.decryptor()
pt = decryptor.update(cipher_text) + decryptor.finalize()
print(pt)
