import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaditos_expres/src/models/category.dart';
import 'package:mandaditos_expres/src/models/order.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';
import 'package:mandaditos_expres/src/widgets/no_data_widget.dart';

class RestaurantOrdersListPage extends StatefulWidget {
  const RestaurantOrdersListPage({Key key}) : super(key: key);

  @override
  _RestaurantOrdersListPageState createState() => _RestaurantOrdersListPageState();
}

class _RestaurantOrdersListPageState extends State<RestaurantOrdersListPage> {
  RestaurantOrdersListController _con = new RestaurantOrdersListController();

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
    return DefaultTabController(
      length: _con.status?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,

              flexibleSpace: Column(
                children: [
                  SizedBox(height: 40),
                  _menuDrawer(),
                ],
              ),
              bottom: TabBar(
                indicatorColor: MyColors.primaryColor,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[400],
                isScrollable: true,
                tabs: List<Widget>.generate(_con.status.length, (index) {
                  return Tab(
                    child: Text(_con.status[index] ?? ''),
                  );
                }),
              ),
            )
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.status.map((String status) {
          return FutureBuilder(
              future:_con.getOrders(status),
              builder: (context, AsyncSnapshot<List<Order>> snapshot) {

                if(snapshot.hasData){
                  if(snapshot.data.length > 0){
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index){
                          return _cardOrder(snapshot.data[index]);
                        }
                    );
                  }
                  else{
                    return NoDataWidget(text: 'No hay ordenes');
                  }
                }
                else{
                  return NoDataWidget(text: 'No hay ordenes');
                }
              }
          );
          }).toList(),
        ),
      ),
    );
  }

  Widget _cardOrder(Order order){
    return GestureDetector(
      onTap: (){
        _con.openBottomSheet(order);
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Orden #${order.id}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'NimbisSans'
                        ),
                      ),
                    ),
                  ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40,left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Pedido: 2015-02-12',
                        style: TextStyle(
                            fontSize: 13
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
                        style: TextStyle(
                            fontSize: 13
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Entregar en: ${order.address?.address ?? ''}',
                        style: TextStyle(
                            fontSize: 13
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopingBag(){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 13),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
        ),
        Positioned(
          right: 16,
          top: 15,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),

          )
        )
      ],
    );
  }

  Widget _textFielSearch(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          suffixIcon: Icon(
              Icons.search,
              color: Colors.grey[400]
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300],
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: Colors.grey[300],
              )
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: _con.logout,
          child: Text('Cerrar Sesion!'),
        ),
      ),
    );
  }*/

  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }
  Widget _drawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: MyColors.primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )
          ),

          ListTile(
            onTap: _con.goToCategoryCreate,
            title: Text('Crear Categoria'),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.goToProductosCreate,
            title: Text('Crear Producto'),
            trailing: Icon(Icons.add_business),
          ),
          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar Rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar Sesion'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}
