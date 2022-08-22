import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfactors/tool/DataManager.dart';
import 'package:tfactors/tool/tools.dart';

class SeeAlso extends StatefulWidget {
  const SeeAlso({Key? key, required this.pid}) : super(key: key);
  final String pid;

  @override
  State<SeeAlso> createState() => _SeeAlsoState();
}

class _SeeAlsoState extends State<SeeAlso> {
  final List<PersonalIdWidget> _personalIdWidgets = [const PersonalIdWidget(number: 0, output: "LOADING...", pid: "PP00")];
  final List<String> _ids = [];
  int _crossAxisCount = 2;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height) {
      _crossAxisCount = 3;
    } else {
      _crossAxisCount = 2;
    }
    return MaterialApp(
        title: "결과지 보기",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("결과 분석"),
              backgroundColor: Colors.purpleAccent,
              elevation: 10.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _crossAxisCount),
                  itemCount: _personalIdWidgets.length,
                  itemBuilder: (BuildContext context, index) {
                    return _personalIdWidgets[index];
                  }),
            )));
  }

  _initfunc() async {
    List<Question> qc = await QuestionsCaller().questionCall();
    _personalIdWidgets.clear();
    //List l = qs.getQuestions();
    _ids.addAll(PersonalId(personalId: widget.pid).list);
    var j = 0;
    setState(() {
      for (int i = 0; i < qc.length; i++) {
        if (_ids[0].substring(0, 3) == qc[i].qid.toString()) {
          _personalIdWidgets.add(PersonalIdWidget(
            pid: _ids[0],
            number: j + 1,
            output: qc[i].label,
          ));
          _ids.removeAt(0);
          if (_ids.isEmpty) return;
          i = -1;
          j++;
        }
      } //for
    });
  }

  @override
  void initState() {
    super.initState();
    _initfunc();
  }
}
