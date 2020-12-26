import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:generic/payment.dart';

import 'category.dart';
import 'forms.dart';
import 'member.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Contas 7 Eh Poko'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // Show loading Dialog
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
    FeedbackForm feedbackForm = FeedbackForm(titleController.text, valueController.text, category, member, payment);
    FormController formController = FormController();
    String dialogTitle;
    formController.submitForm(feedbackForm, (String response) {
      Navigator.of(context).pop();
      print(response);
      if(response == FormController.STATUS_SUCCESS){
        dialogTitle = "Sucesso";
      } else {
        dialogTitle = "Houve uma falha no envio!";
      }

      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text(dialogTitle), actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Fechar"))
        ],
        );
      });
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
