import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:mandaditos_expres/src/pages/delivery/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';
import 'package:mandaditos_expres/src/utils/relative_time_util.dart';
import 'package:mandaditos_expres/src/widgets/no_data_widget.dart';

class DeliveryOrdersDetailPage extends StatefulWidget {
  Order order;

  DeliveryOrdersDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  _DeliveryOrdersDetailPageState createState() => _DeliveryOrdersDetailPageState();
}

class _DeliveryOrdersDetailPageState extends State<DeliveryOrdersDetailPage> {

  DeliveryOrdersDetailController _con = new DeliveryOrdersDetailController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #${_con.order?.id ?? ''}'),
        backgroundColor: MyColors.primaryColor,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.33,
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              endIndent: 30,
              indent: 30,
            ),

            SizedBox(height: 10),
            _textData('Cliente', ' ${_con.order.client?.name ?? ''} ${_con.order.client?.lastname ?? ''}'),
            SizedBox(height: 8),
            _textData('Entregar en:', ' ${_con.order.address?.address ?? ''}'),
            SizedBox(height: 8),
            _textData(
              'Fecha de pedido:',
              ' ${RelativeTimeUtil.getRelativeTime(_con.order.timestamp ?? 0)}'
            ),
            SizedBox(height: 10),
            _textTotalPrice(),
            _con.order.status != 'ENTREGADO' ? _buttonNext() : Container()
          ],
        ),
      ),
      body: _con.order.products.length > 0
          ? ListView(
        children: _con.order.products.map((Product product) {
          return _cardProduct(product);
        }).toList(),
      )
          : NoDataWidget(text: 'Ningun Producto agregado'),
    );
  }

  Widget _textData(String title, String content){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          SizedBox(width: 5),
          Text(
            content,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 20),
      child: ElevatedButton(
        onPressed: _con.updateOrder,
        style: ElevatedButton.styleFrom(
            primary: _con.order?.status == 'DESPACHADO' ? Colors.blue : Colors.green,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  _con.order?.status == 'DESPACHADO' ? 'INICIAR ENTREGA' : 'IR AL MAPA',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 50, top: 10),
                height: 30,
                child: Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _cardProduct(Product product){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product?.name ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Cantidad: ${product.quantity}',
                style: TextStyle(
                    fontSize: 13
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
          ),
          Text(
            '\$ ${_con.total}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          )
        ],
      ),
    );
  }

  Widget _imageProduct(Product product){
    return Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1)
            : AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        fadeInDuration: Duration(milliseconds: 50),
        placeholder: AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}
