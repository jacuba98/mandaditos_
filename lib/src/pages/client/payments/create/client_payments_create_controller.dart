import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:mandaditos_expres/src/models/mercado_pago_card_token.dart';
import 'package:mandaditos_expres/src/models/mercado_pago_document_type.dart';
import 'package:mandaditos_expres/src/models/user.dart';
import 'package:mandaditos_expres/src/provider/mercado_pago_provider.dart';
import 'package:mandaditos_expres/src/utils/my_snackbar.dart';
import 'package:mandaditos_expres/src/utils/shared_pref.dart';
import 'package:http/http.dart';

class ClientPaymentsCreateController {

  BuildContext context;
  Function refresh;
  GlobalKey<FormState> keyForm = new GlobalKey();

  TextEditingController documentNumberController = new TextEditingController();

  String cardNumber = '';
  String expireDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expireDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    refresh();
  }

}