import 'package:flutter/material.dart';
import 'package:untitled/seeAlso.dart';

class Results extends StatefulWidget {
  const Results({Key? key, required this.personalId, required this.value, required this.maxValue})
      : super(key: key);

  final String personalId;
  final List<int> value;
  final List<int> maxValue;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    const TextStyle titleTextStyle = TextStyle(
        color: Colors.amber,
        letterSpacing: 2.0,
        fontSize: 24.0,
        fontWeight: FontWeight.bold);

    return MaterialApp(
        title: "Questions",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("결과 페이지"),
              centerTitle: true,
              backgroundColor: Colors.purpleAccent,
              elevation: 1.0,
              leading: IconButton(
                icon: const Icon(Icons.menu_open),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SeeAlso(pid: widget.personalId)));
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.map_outlined),
                  onPressed: () {

                  },
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("테스트 완료", style: titleTextStyle),
                    const SizedBox(height: 30.0),
                    ValueBar(
                        totalKey: widget.maxValue[0],
                        requireKey: widget.value[0],
                        colorA: Colors.green,
                        colorB: Colors.purple,
                        aaa: 15,
                        textA: "자유지향",
                        textB: "전통지향"),
                    const SizedBox(height: 30.0),
                    ValueBar(
                        totalKey: widget.maxValue[1],
                        requireKey: widget.value[1],
                        colorA: Colors.yellow,
                        colorB: Colors.lightGreen,
                        aaa: 15,
                        textA: "신비-경건",
                        textB: "직제-지식"),
                    const SizedBox(height: 30.0),
                    ValueBar(
                        totalKey: widget.maxValue[2],
                        requireKey: widget.value[2],
                        colorA: Colors.red,
                        colorB: Colors.indigo,
                        aaa: 15,
                        textA: "배타주의",
                        textB: "다원주의"),
                    const SizedBox(height: 30.0),
                    ValueBar(
                        totalKey: widget.maxValue[3],
                        requireKey: widget.value[3],
                        colorA: Colors.cyan,
                        colorB: Colors.purple,
                        aaa: 15,
                        textA: "낙관주의",
                        textB: "비관주의"),

                    //Text(value[0].toString() + "::" + value[1].toString() + "::" +  value[2].toString())
                    const Divider(
                        height: 60.0,
                        color: Colors.grey,
                        thickness: 0.5,
                        endIndent: 30),
                    //Text("personal ID: " + widget.personalId),
                    const Text("좌측 상단 메뉴 버튼을 통해 선택한 내용을 다시 확인할 수 있습니다.")
                  ],
                ),
              ),
            )));
  }
}

class ValueBar extends StatelessWidget {
  const ValueBar(
      {Key? key,
      required this.totalKey,
      required this.requireKey,
      required this.colorA,
      required this.colorB,
      required this.aaa,
      required this.textA,
      required this.textB})
      : super(key: key);
  final int totalKey; //전체 점수
  final int requireKey; //왼쪽 성향이 차지한 점수
  final Color colorA; //왼쪽 성향 색깔
  final Color colorB; //오른쪽 성향 색깔
  final int aaa;
  final String textA;
  final String textB;

  @override
  Widget build(BuildContext context) {
    const TextStyle barTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
    var barWidth = (((totalKey + requireKey)  / 2) / totalKey);
    print("NAME:" + textA + totalKey.toString() + requireKey.toString());
    double abc,bbc;
    if(barWidth * MediaQuery.of(context).size.width < aaa * 2 ){
      abc = 0;
      bbc=(1 - barWidth) * MediaQuery.of(context).size.width-(aaa*4);
    }else if((1-barWidth) * MediaQuery.of(context).size.width < aaa * 2 ){
      abc = barWidth * MediaQuery.of(context).size.width - (aaa*4);
      bbc = 0;
    }else{
      abc = barWidth * MediaQuery.of(context).size.width - (aaa*2);
      bbc=(1 - barWidth) * MediaQuery.of(context).size.width-(aaa*2);
    }
    if (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width >
        4 / 3) {


      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(textA + (barWidth * 100).toStringAsFixed(2), style: barTextStyle),
          Row(
            children: [
              Container(
                height: 40,
                width: abc,
                decoration: BoxDecoration(color: colorA),
              ),
              Container(
                height: 40,
                width: bbc,
                decoration: BoxDecoration(color: colorB),
              ),
            ],
          ),
          Text(textB + ((1 - barWidth) * 100).toStringAsFixed(2), style: barTextStyle),
        ],
      );
    } else {
      return Row(children: [
        Container(
          height: 40,
          width: abc,
          decoration: BoxDecoration(color: colorA),
          child: Text(textA + (barWidth * 100).toStringAsFixed(2), style: barTextStyle),
        ),
        Container(
          height: 40,
          width: bbc,
          decoration: BoxDecoration(color: colorB),
          child: Text(textB + ((1 - barWidth) * 100).toStringAsFixed(2), style: barTextStyle),
        ),
      ]);
    }
  }
}
/*
* 점수계산
* F영역 총 22문제 FP계열 10문제 FN계열 12문제 모두 2배 가산 햇을 때 기준 440점
* 그러므로 100분율로 나타났을 때 현제 위치는 cur*100/220
* 그레픽 상으로는 디자인상 기준치인 240으로 배분하고, 현제화면비율 mirr을 곱해주면 된다.
 */
