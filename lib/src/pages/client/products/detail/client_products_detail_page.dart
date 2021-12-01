import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mandaditos_expres/src/models/product.dart';
import 'package:mandaditos_expres/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';

class ClientProductsDetailPageState extends StatefulWidget {
  Product product;

  ClientProductsDetailPageState({Key key, @required this.product}) : super(key: key);

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
      _con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _imageSlideshow(),
          _textName(),
          _textDescription(),
          Spacer(),
          _addOrRemoveItem(),
          _standartDelivery(),
          _buttonShoppingBag()
        ],
      ),
    );
  }

  Widget _buttonShoppingBag(){
     return Container(
       margin: EdgeInsets.only(top: 30),
       child: ElevatedButton(
         onPressed: () {},
         style: ElevatedButton.styleFrom(
           primary: MyColors.primaryColor,
           padding: EdgeInsets.symmetric(vertical: 5),
         ),
         child: Stack(
           children: [
             Align(
               alignment: Alignment.center,
               child: Container(
                 height: 50,
                 alignment: Alignment.center,
                 child: Text(
                   'Agegar al carrito',
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
                 margin: EdgeInsets.only(left: 50, top: 6),
                 height: 30,
                 child: Image.asset('assets/img/bag.png'),
               ),
             )
           ],
         ),
       ),
     );
  }

  Widget _standartDelivery(){
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
       child: Row(
         children: [
           Image.asset(
             'assets/img/delivery.png',
             height: 17,
           ),
           SizedBox(width: 7),
           Text(
             'Envio estandar',
             style: TextStyle(
               fontSize: 12,
               color: Colors.green
             ),
           )
         ],
       ),
     );
  }

  Widget _addOrRemoveItem(){
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 17),
       child: Row(
         children: [
           IconButton(
               onPressed: () {},
               icon: Icon(
                 Icons.add_circle_outline,
                 color: Colors.grey,
                 size: 30,
               )
           ),
           Text(
             '1',
             style: TextStyle(
               fontSize: 17,
               fontWeight: FontWeight.bold,
               color: Colors.grey
             ),
           ),
           IconButton(
               onPressed: () {},
               icon: Icon(
                 Icons.remove_circle_outline,
                 color: Colors.grey,
                 size: 30,
               )
           ),
           Spacer(),
           Container(
             margin: EdgeInsets.only(right: 15),
             child: Text(
               '\$ ${ _con.product?.price ?? 0}',
               style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.bold
               ),
             ),
           )
         ],
       ),
     );
  }

  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.product?.description ?? '',
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget _textName(){
     return Container(
       alignment: Alignment.centerLeft,
       margin: EdgeInsets.only(right: 30, left: 30, top: 30),
       child: Text(
         _con.product?.name ?? '',
         style: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.bold
         ),
       ),
     );
  }

  Widget _imageSlideshow(){
     return Stack(
       children: [
         ImageSlideshow(
           width: double.infinity,
           height: MediaQuery.of(context).size.height * 0.4,
           initialPage: 0,
           indicatorColor: MyColors.primaryColor,
           indicatorBackgroundColor: Colors.grey,
           children: [
             FadeInImage(
               image: _con.product?.image1 != null
                   ? NetworkImage(_con.product.image1)
                   : AssetImage('assets/img/botella.png'),
               fit: BoxFit.contain,
               fadeInDuration: Duration(milliseconds: 50),
               placeholder: AssetImage('assets/img/no-image.png'),
             ),
             FadeInImage(
               image: _con.product?.image2 != null
                   ? NetworkImage(_con.product.image2)
                   : AssetImage('assets/img/botella.png'),
               fit: BoxFit.contain,
               fadeInDuration: Duration(milliseconds: 50),
               placeholder: AssetImage('assets/img/no-image.png'),
             ),
             FadeInImage(
               image: _con.product?.image3 != null
                   ? NetworkImage(_con.product.image3)
                   : AssetImage('assets/img/botella.png'),
               fit: BoxFit.contain,
               fadeInDuration: Duration(milliseconds: 50),
               placeholder: AssetImage('assets/img/no-image.png'),
             ),
           ],
           onPageChanged: (value) {
             print('Page changed: $value');
           },
           autoPlayInterval: 30000,

           isLoop: true,
         ),
         Positioned(
             left: 10,
             top: 5,
             child: IconButton(
               onPressed: () {},
               icon: Icon(
                 Icons.arrow_back_ios,
                 color: MyColors.primaryColor,
               ),
             )
         )
       ],
     );
  }

  void refresh(){
     setState(() {
     });
  }
}
