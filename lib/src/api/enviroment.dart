import 'package:mandaditos_expres/src/models/mercado_pago_credentials.dart';
class Enviroment{
  static const String API_DELIVERY = "192.168.0.103:3000";
  static const String API_KEY_MAPS = "AIzaSyAhgtsdDIyAMIF6voUlgYoJpjehoR7co5I";

  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
      publicKey: 'TEST-98db4d5d-663a-453b-858e-f66dfd623666',
      accessToken: 'TEST-6028900970379574-062302-e3e5d11b7871ee742832e6351694608f-191014229'
  );
}