import 'dart:convert';

import 'package:flutter/material.dart';
import 'shared_preference.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  String socketURL = "";
  late io.Socket socket = io.io(socketURL, <String, dynamic>{
    'autoConnect': false,
    'reconnection': true,
    'transports': ['websocket'],
  });

  SocketService() {
    debugPrint("SocketIO Service Called On");
    String socketURL = UserPreferences.socketURL;
    socket = io.io(socketURL, <String, dynamic>{
      'autoConnect': false,
      'reconnection': true,
      'transports': ['websocket'],
    });
  }

  initSocket() {
    debugPrint('initSocket');
    socket.connect();
    socket.onConnect((_) {
      debugPrint('Connection Established');
    });
    socket.onDisconnect((_) {
      debugPrint('Connection Disconnected');
    });
    socket.onConnectError((err) {
      debugPrint("onConnectError $err");
    });
    receiveMessage();
  }

  disconnectSocket() {
    debugPrint('disconnectSocket');
    socket.disconnect();
    socket.dispose();
  }

  /*
  // Sending Sockets
  */

  sendMessagePlaceholder() {
    Map<String, dynamic> reqBody = {
      'action': 'event',
      'data': {
        'key': 'value',
      }
    };
    debugPrint("DATA SEND ON SOCKET (event) = ${reqBody.toString()}");
    socket.emit('event', jsonEncode(reqBody));
  }

  /*
  // Receiving Sockets
  */

  receiveMessage() {
    socket.on('event', (newMessage) async {
      debugPrint("DATA RECEIVED ON SOCKET (event) = ${newMessage.toString()}");
    });
  }
}
