import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfactors/result.dart';
import 'package:tfactors/tool/tools.dart';
import 'dart:math';

import 'main.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuestionState();
  }
}

class QuestionState extends State<Questions> {
  //Map<dynamic,dynamic> m = Questions.quests;
  List questions = [];
  String thisQuestion = "Loading...";
  int page = 0;
  String _qid = "init";
  String personalIdentify = "";
  Map<String, int> personalMap = {};
  List<int> value = [0, 0, 0, 0];
  List<int> offerValue = [0, 0, 0, 0];
  List<int> maxValue = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Questions",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(title: const Text("설문조사 중"), centerTitle: true, backgroundColor: Colors.purpleAccent, elevation: 1.0),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("남은 문제 수 $page"),
                Text(thisQuestion),
                const Divider(height: 60.0, color: Colors.grey, thickness: 0.5, endIndent: 30),
                SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              luchQuestionMap(2);
                            },
                            child: const Text("매우 동의"),
                            style: ElevatedButton.styleFrom(primary: Colors.red, elevation: 10.0),
                          ),
                          height: 50,
                        ),
                        const SizedBox(height: 10.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              luchQuestionMap(1);
                            },
                            child: const Text("동의"),
                            style: ElevatedButton.styleFrom(primary: Colors.redAccent, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 15.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              luchQuestionMap(-1);
                            },
                            child: const Text("동의하지 않음"),
                            style: ElevatedButton.styleFrom(primary: Colors.blue, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 10.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              luchQuestionMap(-2);
                            },
                            child: const Text("매우 동의하지 않음"),
                            style: ElevatedButton.styleFrom(primary: Colors.blueAccent, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 15.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              luchQuestionMap(0);
                            },
                            child: const Text("모른다/중립"),
                            style: ElevatedButton.styleFrom(primary: Colors.amber, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ));

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("aaa/questions.json").then((jsonString) {
      List l = jsonDecode(jsonString)['questions'];
      for (int i = 0; i < l.length; i++) {
        questions.add(l[i]);
      }
      page = questions.length;
      /*
      int i = Random().nextInt(questions.length);
      String qid = questions[i]['QID'];
      int? vb0, vb1, vb2, vb3;
      vb0 = questions[i]['FreedomValue'];
      vb1 = questions[i]['FaithfulValue'];
      vb2 = questions[i]['PluralValue'];
      vb3 = questions[i]['ProgressiveValue'];
      setState(() {
        thisQuestion = questions[i]['NAME'];
        personalIdentify = personalIdentify + qid;
        offerValue[0] = vb0 ?? 0;
        offerValue[1] = vb1 ?? 0;
        offerValue[2] = vb2 ?? 0;
        offerValue[3] = vb3 ?? 0;
        questions.removeAt(i);
      });
      lunchQuestion 함수에 통합
      */
      luchQuestionMap(0);
    });
  }

  luchQuestionMap(int cast) {
    value[0] = value[0] + offerValue[0] * cast;
    value[1] = value[1] + offerValue[1] * cast;
    value[2] = value[2] + offerValue[2] * cast;
    value[3] = value[3] + offerValue[3] * cast;
    maxValue[0] = maxValue[0] + offerValue[0].abs() * 2;
    maxValue[1] = maxValue[1] + offerValue[1].abs() * 2;
    maxValue[2] = maxValue[2] + offerValue[2].abs() * 2;
    maxValue[3] = maxValue[3] + offerValue[3].abs() * 2;

    personalMap.addAll({_qid: (cast + 2)});

    if (page == 0) {
      personalMap.remove("init"); //PersonalID에서 제일 앞 문자열 삭제, 문제 초기화 할 때 임의로 끼어들어간 cast값이기 때문.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Results(
                    personalId: PersonalId.fromMap(personalMap: personalMap),
                    value: value,
                    maxValue: maxValue,
                  )));
      return;
    }

    int i = Random().nextInt(questions.length);
    int? vb0, vb1, vb2, vb3;
    vb0 = questions[i]['FreedomValue'];
    vb1 = questions[i]['FaithfulValue'];
    vb2 = questions[i]['PluralValue'];
    vb3 = questions[i]['ProgressiveValue'];
    _qid = questions[i]['QID'];
    offerValue[0] = vb0 ?? 0;
    offerValue[1] = vb1 ?? 0;
    offerValue[2] = vb2 ?? 0;
    offerValue[3] = vb3 ?? 0;

    setState(() {
      thisQuestion = questions[i]['NAME'];
      questions.removeAt(i);
      page = questions.length;
    });
  }

  //K lunch Question
  void lunchQuestion(int cast) {
    personalIdentify = personalIdentify + (cast + 2).toString();
    page = questions.length;
    value[0] = value[0] + offerValue[0] * cast;
    value[1] = value[1] + offerValue[1] * cast;
    value[2] = value[2] + offerValue[2] * cast;
    value[3] = value[3] + offerValue[3] * cast;
    maxValue[0] = maxValue[0] + offerValue[0].abs() * 2;
    maxValue[1] = maxValue[1] + offerValue[1].abs() * 2;
    maxValue[2] = maxValue[2] + offerValue[2].abs() * 2;
    maxValue[3] = maxValue[3] + offerValue[3].abs() * 2;
    if (page == 0) {
      personalIdentify = personalIdentify.substring(1); //PersonalID에서 제일 앞 문자열 삭제, 문제 초기화 할 때 임의로 끼어들어간 cast값이기 때문.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Results(
                    personalId: PersonalId(personalId: personalIdentify),
                    value: value,
                    maxValue: maxValue,
                  )));
      return;
    }
    int i = Random().nextInt(questions.length);
    int? vb0, vb1, vb2, vb3;
    vb0 = questions[i]['FreedomValue'];
    vb1 = questions[i]['FaithfulValue'];
    vb2 = questions[i]['PluralValue'];
    vb3 = questions[i]['ProgressiveValue'];
    String qid = questions[i]['QID'];
    offerValue[0] = vb0 ?? 0;
    offerValue[1] = vb1 ?? 0;
    offerValue[2] = vb2 ?? 0;
    offerValue[3] = vb3 ?? 0;
    personalIdentify = personalIdentify + qid;
    setState(() {
      page = questions.length;
      thisQuestion = questions[i]['NAME'];
      questions.removeAt(i);
    });
  }
}
