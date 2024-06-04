import asyncio
import threading
from time import sleep
import websockets
import socket

async def handle_client(websocket):
    print("handling_client")
    message = await websocket.recv()
    print(f"Message is {message}")
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.settimeout(1.0)    
    addr = ("192.168.4.1", 4242)
    
    client_socket.sendto(message.encode(), addr)

def start_ws():    
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    server = websockets.serve(handle_client, 'localhost',4242, ping_interval=None)
    loop.run_until_complete(server)
    loop.run_forever()


def start():
    thread = threading.Thread(target=start_ws)
    thread.daemon = True
    thread.start()

    


start()

while True:
    print("Running thread")
    sleep(0.5)
