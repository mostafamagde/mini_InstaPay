import 'dart:async';
import 'dart:developer';
import 'package:socket_io_client_flutter/socket_io_client_flutter.dart';
import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/notifications/data/models/notfication_model.dart';

class SocketService {
  SocketService._();

  static final SocketService instance = SocketService._();
  late Socket _socket;
  Stream<NotificationModel> get stream => _controller.stream;

  final StreamController<NotificationModel> _controller = StreamController<NotificationModel>.broadcast();

  void connect() {
    log('enter');
    _socket = io(
      ApiConstants.baseUrl,
      {
        'transports': ['websocket'],
        'autoConnect': true,
        'auth': {"userId": UserModel.instance.id},
      },
    );

    _socket.onConnect((e) {
      log('Connected to Socket.IO server');
      // _controller.add('');
    });

    _socket.on('notification', (data) {
      log(data.toString());

      _controller.add(NotificationModel.fromJson(data));
    });

    _socket.onDisconnect((_) {
      log('Disconnected from Socket.IO server');
    });
  }

  void sendMessage(String message) {
    log('sendMessage');
    _socket.emit('message', message);
  }

  void disconnect() {
    _socket.disconnect();
    _controller.close();
  }
}
