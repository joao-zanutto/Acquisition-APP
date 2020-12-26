
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void StringCallback(String str);

class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({Key key, @required this.onSonChanged}) : super(key: key);
  StringCallback onSonChanged;

  @override
  CategoryDropdownState createState() => CategoryDropdownState( onSonChanged: this.onSonChanged );
}

class CategoryDropdownState extends State<CategoryDropdown> {
  String dropdownValue = 'Mercado';
  StringCallback onSonChanged;

  CategoryDropdownState({@required this.onSonChanged}) {
    onSonChanged(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: true,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      //style: TextStyle(color: Colors.green),
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          onSonChanged(dropdownValue);
        });
      },
      items: <String>['Mercado', 'Gás', 'Pets']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
