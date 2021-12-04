import 'package:flutter/material.dart';
import 'package:mandaditos_expres/src/models/address.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/address_provider.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';

class ClientAddressListController {
  BuildContext context;
  Function refresh;

  List<Address> address = [];
  AddressProvider _addressProvider =  new AddressProvider();
  User user;
  SharedPref _sharedPref = new SharedPref();

  int radioValue = 0;

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));

    _addressProvider.init(context, user);
  }
  void handleRadioValueChange(int value){
    radioValue = value;

    refresh();
  }

  Future<List<Address>> getAddress() async{
    address = await _addressProvider.getByUser(user.id);
    return address;
  }

  void goToNewAddress(){
    Navigator.pushNamed(context, 'client/address/create');
  }
}