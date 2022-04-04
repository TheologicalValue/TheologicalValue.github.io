import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/tool/tools.dart';

class DecodePage extends StatelessWidget {
  const DecodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Decoding",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("개발자 페이지"),
            centerTitle: true,
            backgroundColor: Colors.purpleAccent,
            elevation: 1.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonTheme(
                  child: ElevatedButton(
                      onPressed: () {
                        PersonalId id = PersonalId(
                            personalId:
                                'FP43FN34PP44FNB4FN81FP20FN50PN71FP91PP13FP34PN14PP63FP11NP11FP71FP10FN90PP20PN60PP31PN51PN33FP83PP51FNA1FN40FP61FN60PP71NN11FN13FN23FP53');
                        rootBundle.loadString("aaa/questions.json").then((jsonString) {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DecodeTest(ids: id.list,jsonString: jsonString)));});},
                      child: const Text(
                        "시작하기",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10.0)),
                  minWidth: 100,
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}

class DecodeTest extends StatefulWidget {
  const DecodeTest({Key? key, required this.ids, required this.jsonString})
      : super(key: key);
  final List<String> ids;
  final String jsonString;

  @override
  State<DecodeTest> createState() => _DecodeTestState();
}

class _DecodeTestState extends State<DecodeTest> {
  List<String> questions = [];
  List<PersonalIdWidget> personalIdWidgets = [
    const PersonalIdWidget(number: 0, output: "LOADING...", pid: "PP00")
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: "Decoding",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("개발자 페이지"),
              centerTitle: true,
              backgroundColor: Colors.purple,
              elevation: 1.0,
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: personalIdWidgets,
            )));
  }

  @override
  void initState() {
    super.initState();
      personalIdWidgets.clear();
      List l = jsonDecode(widget.jsonString)['questions'];
      var j = 0;
      for (int i = 0; i < l.length; i++) {
        if (widget.ids[j].substring(0,3) == l[i]['QID'].toString()) {
          questions.add(l[i]['NAME']);
          personalIdWidgets.add(PersonalIdWidget(
            pid: widget.ids[j],
            number: j,
            output: l[i]['NAME'],
          ));
          j++;
          if((widget.ids.length-1)<j){
            break;
          }
          i = -1;
        }
      }
  }
}
