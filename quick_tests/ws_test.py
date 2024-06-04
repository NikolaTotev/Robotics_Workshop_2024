import websocket

def on_message(ws, message):
    print(f"Msg: {message}")


def on_error(ws, err):
    print(f"Error: {err}")

def on_close(ws):
    print(f"Closed")

def on_open(ws):
    print("Opened")

ws = websocket.WebSocketApp("ws://localhost:4242", on_message=on_message, on_error=on_error, on_close=on_close)

ws.on_open=on_open
print("starting!")
ws.run_forever()