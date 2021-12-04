import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mandaditos_expres/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';
import 'package:mandaditos_expres/src/widgets/no_data_widget.dart';

class ClientAddressMapPage extends StatefulWidget {
  const ClientAddressMapPage({Key key}) : super(key: key);

  @override
  _ClientAddressMapPageState createState() => _ClientAddressMapPageState();
}

class _ClientAddressMapPageState extends State<ClientAddressMapPage> {

  ClientAddressMapController _con =  new ClientAddressMapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Ubica tu direccion en el mapa'),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: _cardAdderss(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonAccept(),
          )
        ],
      ),
    );
  }

  Widget _buttonAccept(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 70),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
            'Selecciona este punto'
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }

  Widget _cardAdderss(){
    return Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Calle S/N, Avenida S/N',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/my_location.png',
      width: 65,
      height: 65,
    );
  }

  Widget _googleMaps(){
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  void refresh(){
    setState(() {});
  }
}
