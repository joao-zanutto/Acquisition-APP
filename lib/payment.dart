

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void IntCallback(int val);

class PaymentRadio extends StatefulWidget {
  PaymentRadio({Key key, @required this.onSonChanged}) : super(key:key);
  IntCallback onSonChanged;

  @override
  PaymentRadioState createState() => PaymentRadioState( onSonChanged: this.onSonChanged);
}

class PaymentRadioState extends State<PaymentRadio> {
  IntCallback onSonChanged;
  int _radioValue = 0;

  PaymentRadioState({@required this.onSonChanged}){
    _radioValue = 0;
    onSonChanged(_radioValue);
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    onSonChanged(_radioValue);
  }

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: 0,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          Text('Cartão da Rep', style: new TextStyle(fontSize: 16.0),),
          Radio(
            value: 1,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          Text('Minha Grana', style: new TextStyle(fontSize: 16.0,),)
        ]);
  }
}
