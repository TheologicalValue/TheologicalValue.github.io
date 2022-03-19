import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoacheckers/result.dart';
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
  String personalIdentify = "";
  List<int> value = [0, 0, 0];
  List<int> offerValue = [0, 0, 0];
  List<int> maxValue = [0, 0, 0];

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Questions",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("설문조사 중"),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
          elevation: 1.0),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("남은 문제 수 $page"),
                Text(thisQuestion),
                const Divider(
                    height: 60.0,
                    color: Colors.grey,
                    thickness: 0.5,
                    endIndent: 30),
                SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              lunchQuestion(2);
                            },
                            child: const Text("매우 동의"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red, elevation: 10.0),
                          ),
                          height: 50,
                        ),
                        const SizedBox(height: 10.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              lunchQuestion(1);
                            },
                            child: const Text("동의"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 15.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              lunchQuestion(-1);
                            },
                            child: const Text("동의하지 않음"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 10.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              lunchQuestion(-2);
                            },
                            child: const Text("매우 동의하지 않음"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent, elevation: 10.0),
                          ),
                          minWidth: 100,
                          height: 50,
                        ),
                        const SizedBox(height: 15.0),
                        ButtonTheme(
                          child: ElevatedButton(
                            onPressed: () {
                              lunchQuestion(0);
                            },
                            child: const Text("모른다/중립"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber, elevation: 10.0),
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
      int i = Random().nextInt(questions.length);
      String qid = questions[i]['QID'];
      int? vb0, vb1, vb2;
      vb0 = questions[i]['FreedomValue'];
      vb1 = questions[i]['FaithfulValue'];
      vb2 = questions[i]['PluralValue'];
      setState(() {
        thisQuestion = questions[i]['NAME'];
        personalIdentify = personalIdentify + qid;
        offerValue[0] = vb0?? 0;
        offerValue[1] = vb1?? 0;
        offerValue[2] = vb2?? 0;
        questions.removeAt(i);
      });
    });
  }
  /*
  * QID 해석법
  * PN4 전 중 후
  * 전  F  P  N  그 문제가 어떤 성향을 측정하기 위한 문제에 속하는지 알려줌 F는 자유주의 척도, P는 경건주의 척도, N는 신정통주의 경향
  * 중  P  N     그 문제가 그 성향에 긍정적으로 응답했을 때 총점에 가산하는지 감산하는지 알려줌 P는 가산, N은 감산함
  * 후  1 2 ... A B   문제와 체점방식에 속한 문제들 중 몇 번쩨에 속하는 문제인지 알려줌, PN4는 경건주의 척도에서 긍정응답을 했을 때 감산하는 문제 중 4번째 문제
  */
  void lunchQuestion(int cast) {
    personalIdentify = personalIdentify + (cast + 2).toString();
    page = questions.length;
    value[0] = value[0] + offerValue[0] * cast;
    value[1] = value[1] + offerValue[1] * cast;
    value[2] = value[2] + offerValue[2] * cast;
    maxValue[0] = maxValue[0] + offerValue[0].abs() * 2;
    maxValue[1] = maxValue[1] + offerValue[1].abs() * 2;
    maxValue[2] = maxValue[2] + offerValue[2].abs() * 2;
    if (page == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Results(personalId: personalIdentify, value: value, maxValue: maxValue,)));
      return;
    }
    int i = Random().nextInt(questions.length);
    int? vb0, vb1,vb2;
    vb0 = questions[i]['FreedomValue'];
    vb1 = questions[i]['FaithfulValue'];
    vb2 = questions[i]['PluralValue'];
    String qid = questions[i]['QID'];
    offerValue[0] = vb0?? 0;
    offerValue[1] = vb1?? 0;
    offerValue[2] = vb2?? 0;
    setState(() {
      page = questions.length;
      thisQuestion = questions[i]['NAME'];
      personalIdentify = personalIdentify + qid;
      questions.removeAt(i);
      if (page == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage()));
      }
    });
  }
}
