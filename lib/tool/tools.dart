import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//K personalId obj
class PersonalId {
  String personalId;
  final List<String> list;
  Map<String, int> personalMap;

  PersonalId({required this.personalId})
      : list = [],
        personalMap = {} {
    for (int i = 0; i < (personalId.length / 4); i++) {
      var j = personalId.substring(4 * i, 4 * i + 4);
      list.add(j);
      personalMap.addAll({personalId.substring(4 * i, 4 * i + 3): int.parse(personalId.substring(4 * i + 3, 4 * i + 4))});
    } //String을 인자로 받아서 4개 문자 단위로 쪼개고 배열에 저장
  }

  PersonalId.fromList({required this.list})
      : personalId = "init",
        personalMap = {} {
    var v = "";
    for (int i = 0; i < list.length; i++) {
      v = v + list[i].toString();
      personalMap.addAll({list[i].substring(0, 3): int.parse(list[i].substring(3))});
    }
    personalId = personalId.replaceAll("init", v);
  }

  PersonalId.fromMap({required this.personalMap})
      : personalId = "init",
        list = [] {
    List key = personalMap.keys.toList();
    List value = personalMap.values.toList();
    String s = "";
    for (int i = 0; i < key.length; i++) {
      s = s + key[i].toString() + value[i].toString();
      list.add(key[i].toString() + value[i].toString());
    }
    personalId = personalId.replaceAll("init", s);
  }

  bool isSimilarAThanB(List<int> value, List<int> tValues, List<int> uValues) {
    var b = ((value[0] - tValues[0]) * (value[0] - tValues[0]) +
            (value[1] - tValues[1]) * (value[1] - tValues[1]) +
            (value[2] - tValues[2]) * (value[2] - tValues[2]) +
            (value[3] - tValues[3]) * (value[3] - tValues[3])) -
        ((value[0] - uValues[0]) * (value[0] - uValues[0]) +
            (value[1] - uValues[1]) * (value[1] - uValues[1]) +
            (value[2] - uValues[2]) * (value[2] - uValues[2]) +
            (value[3] - uValues[3]) * (value[3] - uValues[3])); //유사도 계산법, 4차원 공간 안에 u와 v교회의 특성을 배열한 후 value와의 거리의 제곱을 계산, 그 값들의 단순 차를 비교
    if (b > 0) {
      return false; //u가 t보다 더 value와 비슷하다.
    } else {
      return true;
    }
  }

  bool isSimilarAThanBatPart(List<int> value, List<int> tValues, List<int> uValues, int cast) {
    var b = ((value[cast] - tValues[cast]).abs()) / ((value[cast] - uValues[cast]).abs());
    if (b > 1) {
      return false;
    } else {
      return true;
    }
  }

  List<int> getValues(List questions) {
    List<int> subValue = [0, 0, 0, 0];
    var lists = list;
    var v = lists[0].substring(0, 3);
    for (int i = 0; i < questions.length; i++) {
      if (questions[i]['QID'] == v) {
        int cast = int.parse(lists[0].substring(lists[0].length - 1)) - 2;

        int vb0, vb1, vb2, vb3;
        vb0 = questions[i]['FreedomValue'] ?? 0;
        vb1 = questions[i]['FaithfulValue'] ?? 0;
        vb2 = questions[i]['PluralValue'] ?? 0;
        vb3 = questions[i]['ProgressiveValue'] ?? 0;

        subValue[0] = subValue[0] + vb0 * cast;
        subValue[1] = subValue[1] + vb1 * cast;
        subValue[2] = subValue[2] + vb2 * cast;
        subValue[3] = subValue[3] + vb3 * cast;
        lists.removeAt(0);

        if (lists.isEmpty) return subValue;

        questions.removeAt(i);
        v = lists[0].substring(0, 3);
        i = -1;
      }
    }
    return [1, 1, 1, 1]; //Exception
  }
}

//K: Json Classes
class Questionsjson {
  dynamic _jsonString;
  dynamic _jsonResponse;
  Future<void> loadFile() async {
    _jsonString = await rootBundle.loadString("aaa/questions.json");
    _jsonResponse = jsonDecode(_jsonString);
  }

  List getQuestions() {
    return _jsonResponse['questions'];
  }
}

class Setsjson {
  dynamic _jsonString;
  dynamic _jsonResponse;
  Future<void> loadFile() async {
    _jsonString = await rootBundle.loadString("aaa/sets.json");
    _jsonResponse = jsonDecode(_jsonString);
  }

  List getSets() {
    return _jsonResponse['sets'];
  }
}

class SimularValueResearcher {
  final dynamic _setsList;
  final PersonalId target;

  SimularValueResearcher(this._setsList, this.target);

  int getSimularStructureInSense(List<int> values) {
    int maxSimularValue = 0;
    for (int i = 1; i < _setsList.length; i++) {
      if (target.isSimilarAThanB(values, (_setsList[maxSimularValue]['Values'] as List).cast<int>(), (_setsList[i]['Values'] as List).cast<int>())) {
        maxSimularValue = maxSimularValue;
      } else {
        maxSimularValue = i;
      }
    }
    return maxSimularValue;
  }
}

//K PersonalId Widget
class PersonalIdWidget extends StatelessWidget {
  const PersonalIdWidget({Key? key, required this.number, required this.output, required this.pid}) : super(key: key);
  final String pid;
  final int number;
  final String output;

  @override
  Widget build(BuildContext context) {
    var value = int.parse(pid[3]);
    var color = Colors.blue;
    if (value > 2) {
      color = Colors.red;
    } else if (value == 2) {
      color = Colors.yellow;
    }

    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.deepPurple,
      child: Container(
        child: Stack(
          children: [
            Text(number.toString() + ".", style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
            Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0), child: Text(output)),
          ],
        ),
        color: color,
      ),
    );
  }
}
