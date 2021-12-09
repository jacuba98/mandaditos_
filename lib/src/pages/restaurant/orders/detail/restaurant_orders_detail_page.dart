import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/detail/restaurant_orders_detail_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';
import 'package:mandaditos_expres/src/utils/relative_time_util.dart';
import 'package:mandaditos_expres/src/widgets/no_data_widget.dart';

class RestaurantOrdersDetailPage extends StatefulWidget {
  Order order;

  RestaurantOrdersDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  _RestaurantOrdersDetailPageState createState() => _RestaurantOrdersDetailPageState();
}

class _RestaurantOrdersDetailPageState extends State<RestaurantOrdersDetailPage> {

  RestaurantOrdersDetailController _con = new RestaurantOrdersDetailController();

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
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              endIndent: 30,
              indent: 30,
            ),
            _textDescription(),
            _dropDown(_con.users),
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
            _buttonNext()
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

  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Asignar repartidor',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: MyColors.primaryColor,
          fontSize: 18
        ),
      ),
    );
  }

  Widget _dropDown(List<User> users) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Repartidores',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(users),
                  value: _con.idDelivery,
                  onChanged: (option) {
                    setState(() {
                      print('Repartidor seleccionda $option');
                      _con.idDelivery = option; // ESTABLECIENDO EL VALOR SELECCIONADO
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<String>> list = [];
    users.forEach((users) {
      list.add(DropdownMenuItem(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: FadeInImage(
                image: users.image != null
                    ? NetworkImage(users.image)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ),
            SizedBox(width: 5),
            Text(users.name)
          ],
        ),
        value: users.id,
      ));
    });

    return list;
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
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
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
                  'DESPACHAR ORDEN',
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
                  Icons.check_circle,
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
