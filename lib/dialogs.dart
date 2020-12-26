
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs{
  static showLoadingDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Dialog(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        Text("Carregando"),
                        CircularProgressIndicator(),
                      ]
                  )
              )
          );
        });
  }

  static popDialog(BuildContext context){
    Navigator.of(context).pop();
  }

  static showResultDialog(BuildContext context, String resultDialogTitle){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(resultDialogTitle),
        actions: [
          FlatButton(
              onPressed: (){
                popDialog(context);
                },
              child: Text("Fechar"))
        ],
      );
    });
  }
}