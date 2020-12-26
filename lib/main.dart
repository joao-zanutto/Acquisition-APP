import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:generic/payment.dart';

import 'category.dart';
import 'dialogs.dart';
import 'forms.dart';
import 'member.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Contas 7 Eh Poko'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  MoneyMaskedTextController valueController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  String emptyStringValidator(value) {
    if (value.isEmpty) {
      return "Escreva alguma coisa aqui!";
    }
    return null;
  }

  void sendData() {
    FeedbackForm feedbackForm = FeedbackForm(titleController.text, valueController.text, category, member, payment);
    FormController formController = FormController();

    Dialogs.showLoadingDialog(context);

    formController.submitForm(feedbackForm, (String response) {
      Dialogs.popDialog(context);

      String resultDialogTitle;

      if(response == FormController.STATUS_SUCCESS){
        resultDialogTitle = "Sucesso";
      } else {
        resultDialogTitle = "Houve uma falha no envio!";
      }

      Dialogs.showResultDialog(context, resultDialogTitle);
    });
  }

  String title, value, category, member, payment;

  void updateMember(String newMember){
    this.member = newMember;
  }

  void updateCategory(String newCategory){
    this.category = newCategory;
  }

  void updatePayment(int newPayment){
    if(newPayment == 0)
      this.payment = "Cartão da Rep";
    else
      this.payment = "Minha Grana";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10), 
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Nome da transação",),
                              validator: emptyStringValidator,
                              controller: titleController,
                          )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(labelText: "Valor da transação"),
                              controller: valueController,
                            )
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10), child: CategoryDropdown(onSonChanged: updateCategory)),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10), child: MemberDropdown(onSonChanged: updateMember)),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10), child: PaymentRadio(onSonChanged: updatePayment,)),
                      ]),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendData,
        tooltip: 'Increment',
        child: Icon(Icons.upload_rounded),
      ),
    );
  }
}
