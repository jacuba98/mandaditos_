import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:mandaditos_expres/src/api/enviroment.dart';

class SocketIOProvider {

  // SOCKET IO
  SocketIO _socketIO;
  SocketIOManager _manager = new SocketIOManager();
  String namespace; 
  String query;
  String key;
  Function onReceived;

  SocketIOProvider({@required this.namespace, @required this.query}) {
    _instanceSocketIO();
  }

   /// INICIAR SOCKET IO
   
  void _instanceSocketIO(){
    print('namespace $namespace');
    print('query $query');
    try {
      _socketIO = SocketIOManager().createSocketIO('http://${Enviroment.API_DELIVERY}', namespace, query: query);
      _socketIO.init();
      _socketIO.connect();
    }
    catch (e) {
      print('Error al conectarse a socket io $e');
    }
  }

  /// SUSCRIBIR METODO A SOCKET IO
   
  void subscribeMethod(String key, Function onReceived) {
    if (_socketIO != null) {
      _socketIO.subscribe(key, onReceived);
    }
  } 
 
  /// DESUSCRIBIR METODO A SOCKET IO
   
  void unsubscribeMethod(String key, Function onReceived) {
    if (_socketIO != null) {
      _socketIO.unSubscribe(key, onReceived);
    }
  } 
  
  /// EMITIR UN MENSAJE A SOCKET IO
   
  void emit(String key, Map<String, dynamic> map) {
    if (_socketIO != null) {
      final data = jsonEncode(map);
      _socketIO.sendMessage(key, data);
    }
  } 

  /// DESCONECTAR SOCKET IO
   
  void disconnectSocket() {
    if (_socketIO != null) {
      _socketIO.disconnect();
      // _socketIO.destroy();
    }
  }

  /// DESTRUIR LA INSTANCIA DE SOCKET IO
   
  void destroySocket() {
    if (_socketIO != null) {
      // _socketIO.destroy();
      // SocketIOManager().destroySocket(_socketIO);
      _manager.destroyAllSocket();
    }
  }

  /// DESUSCRIBIR TODOS LOS EVENTOS DE SOCKET IO
   
  void unSubscribes() {
    if (_socketIO != null) {
      _socketIO.unSubscribesAll();
    }
  }

  /// ELIMINAR TODOS LOS LISTENERS DEL SOCKE
   
  void deleteAllListeners() {
    if (_socketIO != null) {
      print('SOCKET DESTRUIDO: ${_socketIO.getId()}');
      unSubscribes();
      disconnectSocket();
      // _socketIO = null;
      //destroySocket();
    }
  }

}