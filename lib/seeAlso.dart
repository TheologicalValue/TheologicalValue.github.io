import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/tool/tools.dart';

class SeeAlso extends StatefulWidget {
  const SeeAlso({Key? key, required this.pid}) : super(key: key);
  final String pid;

  @override
  State<SeeAlso> createState() => _SeeAlsoState();
}

class _SeeAlsoState extends State<SeeAlso> {
  final List<PersonalIdWidget> _personalIdWidgets = [
    const PersonalIdWidget(number: 0, output: "LOADING...", pid: "PP00")
  ];
  final List<String> _ids = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "결과지 보기",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("결과 분석"),
          backgroundColor: Colors.purpleAccent,
          elevation: 10.0,
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _personalIdWidgets.length,
              itemBuilder: (BuildContext context, index) {
                return _personalIdWidgets[index];
              }
          ),
        )
          /*GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: _personalIdWidgets,
        )*/
      )
    );
  }
  @override
  void initState() {
    super.initState();
    rootBundle.loadString("aaa/questions.json").then((jsonString) {
      List l = jsonDecode(jsonString)['questions'];
      _personalIdWidgets.clear();
      print(widget.pid);
      _ids.addAll(PersonalId(personalId: widget.pid).list);
      var j = 0;
      setState(() {
      for (int i = 0; i < l.length; i++) {
        if (_ids[j].substring(0,3) == l[i]['QID'].toString()) {
          //questions.add(l[i]['NAME']);

            _personalIdWidgets.add(PersonalIdWidget(
              pid: _ids[j],
              number: j+1,
              output: l[i]['NAME'],
            ));
          j++;
          if((_ids.length-1)<j){
            break;
          }
          i = -1;
        }
      } //for
      });
    });
  }
}