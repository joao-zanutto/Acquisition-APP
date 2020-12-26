
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void StringCallback(String str);

class MemberDropdown extends StatefulWidget {
  MemberDropdown({Key key, @required this.onSonChanged}) : super(key: key);
  final StringCallback onSonChanged;

  @override
  MemberDropdownState createState() => MemberDropdownState( onSonChanged: this.onSonChanged);
}

class MemberDropdownState extends State<MemberDropdown> {
  String member;
  final StringCallback onSonChanged;

  MemberDropdownState({@required this.onSonChanged}) {
    _readMember();
  }

  _readMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      member = (prefs.getString('member') ?? "Mini");
      onSonChanged(member);
    });
  }

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      isExpanded: true,
      value: member,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      //style: TextStyle(color: Colors.green),
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      onChanged: (String newValue) async {
        setState(() {
          member = newValue;
        });
        onSonChanged(member);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('member', member);
      },
      items: <String>['Mini', 'Fuga', 'Renner', 'Borel', 'Galego', 'Gui', 'Sub', 'Vó', 'Firmino']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
