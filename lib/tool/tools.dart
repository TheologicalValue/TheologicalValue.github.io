import 'package:flutter/material.dart';

class PersonalId {
  final String personalId;
  final List<String> _list;

  PersonalId({required this.personalId}) : _list = [] {
    for (int i = 0; i < (personalId.length / 4); i++) {
      var j = personalId.substring(4*i, 4*i+4);
      _list.add(j);
    }
  }

  get list {
    return _list;
  }

  get pid {
    return personalId;
  }
}
class PersonalIdWidget extends StatelessWidget {
  const PersonalIdWidget({Key? key, required this.number, required this.output, required this.pid}) : super(key: key);
  final String pid;
  final int number;
  final String output;

  @override
  Widget build(BuildContext context) {
    var value = int.parse(pid[3]);
    var color = Colors.blue;
    if(value<2){
      color = Colors.red;
    }else if(value == 2){
      color = Colors.yellow;
    }

    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.deepPurple,
      child: Container(
        child: Stack(
          children: [
            Text(number.toString() + ".", style: const TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold)),
            Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
            child: Text(output)),
          ],
        ),
        color:color,
      ),
    );
  }

}