import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mandaditos_expres/src/models/category.dart';
import 'package:mandaditos_expres/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:mandaditos_expres/src/utils/my_colors.dart';

class RestaurantOrdersLitsPage extends StatefulWidget {
  const RestaurantOrdersLitsPage({Key key}) : super(key: key);

  @override
  _RestaurantOrdersLitsPageState createState() => _RestaurantOrdersLitsPageState();
}

class _RestaurantOrdersLitsPageState extends State<RestaurantOrdersLitsPage> {
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
      length: _con.categories.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [
              _shopingBag(),
            ],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 40),
                _menuDrawer(),
                SizedBox(height: 20),
                _textFielSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index){
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
              }),
            ),
          )
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category){
            return Text('Hola');
          }).toList(),
        )
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
