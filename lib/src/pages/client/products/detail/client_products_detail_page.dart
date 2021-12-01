import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaditos_expres/src/pages/client/products/detail/client_products_detail_controller.dart';

class ClientProductsDetailPageState extends StatefulWidget {
  const ClientProductsDetailPageState({Key key}) : super(key: key);

  @override
  _ClientProductsDetailPageStateState createState() => _ClientProductsDetailPageStateState();
}

class _ClientProductsDetailPageStateState extends State<ClientProductsDetailPageState> {

  ClientProductsDetailController _con = new ClientProductsDetailController();

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Text('Modal SHEET'),
    );
  }

  void refresh(){
     setState(() {
     });
  }
}
