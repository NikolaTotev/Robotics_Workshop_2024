import threading
import websocket
import time


ws_addr = '127.0.0.1:4242/websocket'

def on_socket_message(message):
    print(f"Got message! {message}")

ws = websocket.WebSocketApp("ws://"+ws_addr, on_message=on_socket_message)
ws_thread = threading.Thread(target=ws.run_forever)
ws_thread.daemon=True
ws_thread.start()

while True:
    print("WS Running")
    time.sleep(0.5)

