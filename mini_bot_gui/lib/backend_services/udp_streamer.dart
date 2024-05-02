import 'dart:io';
import 'dart:convert';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'dart:html';

class UdpStreamer {

  
  //192.168.4.1. 2390
  void sendData(String command, String robotIp, int robotPort) {
    //  final channel = WebSocketChannel.connect(
    //   Uri.parse('ws://127.0.0.1:8888'),
    // );    

    // channel.sink.add(command);
  
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
      socket.send(
          Utf8Codec().encode(command), InternetAddress(robotIp), robotPort);
      socket.listen((event) {
        if (event == RawSocketEvent.write) {
          socket.close();
          print("single closed");
        }
      });
    });
  }
}
