import http.server
import socketserver
from urllib.parse import unquote
import json

PORT = 8000

def escape(inp):
    blacklisted = ["bdefgijklmnopstuvxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./,<>_;:~!@#$%^&[]{}"]
    secret = r"1_7H1NK_U_C4N_8EC0M3_A_CTF_3XP3RT"
    for char in inp:
        if char in blacklisted:
            return 'I dont know what you are talking about'
    return eval(eval(inp))

class myHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):  # Changed from do_GET to do_POST
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        try:
            data = json.loads(post_data.decode('utf-8'))
            giveninp = data['input']
            escaped = escape(unquote(giveninp))
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.send_header("Access-Control-Allow-Methods", "POST, OPTIONS")
            self.send_header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type")
            self.end_headers()
            
            json_string = json.dumps({"message": escaped})
            self.wfile.write(json_string.encode())
        
        except Exception as e:
            self.send_response(400)
            self.send_header("Content-type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.send_header("Access-Control-Allow-Methods", "POST, OPTIONS")
            self.send_header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type")
            self.end_headers()
            
            json_string = json.dumps({"message": "I dont know what you are talking about"})
            self.wfile.write(json_string.encode())

httpd = socketserver.TCPServer(("0.0.0.0", PORT), myHandler)
httpd.serve_forever()