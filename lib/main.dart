import 'package:flutter/material.dart';
import 'Questions.dart';
import 'decodePersonal.dart';

void main() {
  runApp(const TeoaCheck());
}

class TeoaCheck extends StatelessWidget {
  const TeoaCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "신학 성향 측정기", theme: ThemeData(primarySwatch: Colors.purple), home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle meinbut =
        ElevatedButton.styleFrom(primary: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), elevation: 10.0);
    const TextStyle titleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 24.0, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
            title: const Text("신학 성향 측정기"),
            centerTitle: true,
            backgroundColor: Colors.purpleAccent,
            elevation: 1.0,
            leading: IconButton(
              icon: const Icon(Icons.menu_open),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const DecodePage()));
              },
            )),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("신학 성향 측정기", style: titleTextStyle),
                const SizedBox(height: 10.0),
                const Text("이 설문조사는 개신교인의 여러 가치를 4 가지의 신학적 성향을 구별해 측정함으로써, 어떤 성향을 가지고 있는지 진단합니다. 이 설문조사는 자신이 가지고 있는 성향을 객관적으로 표현할 수 있는 지표를 제공합니다."),
                const Divider(height: 60.0, color: Colors.grey, thickness: 0.5, endIndent: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconPar(
                        name: "aaa/Presbyterian.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PrebysterianAndLiberalPage()));
                        },
                        radious: 15.0),
                    const Text("전통주의 척도"),
                    const Text("자유주의 척도"),
                    IconPar(
                        name: "aaa/Liberian.jpg",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PrebysterianAndLiberalPage()));
                        },
                        radious: 15.0),
                    //SizedBox(width: 15.0), // cf) padding
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconPar(
                        name: "aaa/Pietism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PietismAndAntiPietismPage()));
                        },
                        radious: 15.0),
                    const Text("직제-지식 척도"),
                    const Text("신비-경건 척도"),
                    IconPar(
                        name: "aaa/antiPietism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PietismAndAntiPietismPage()));
                        },
                        radious: 15.0),
                    //SizedBox(width: 15.0), // cf) padding
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconPar(
                        name: "aaa/antiPluralism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PluralismAndAntiPluralismPage()));
                        },
                        radious: 15.0),
                    const Text("배타주의 척도"),
                    const Text("다원주의 척도"),
                    IconPar(
                        name: "aaa/Pluralism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PluralismAndAntiPluralismPage()));
                        },
                        radious: 15.0),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconPar(
                        name: "aaa/antiProgessivism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ProgessiveAndAntiProgressivePage()));
                        },
                        radious: 15.0),
                    const Text("비관주의 척도"),
                    const Text("낙관주의 척도"),
                    IconPar(
                        name: "aaa/Progessivism.png",
                        onTab: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ProgessiveAndAntiProgressivePage()));
                        },
                        radious: 15.0),
                  ],
                ),
                const SizedBox(height: 10.0),
                const SizedBox(height: 10.0),
                ButtonTheme(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Questions()));
                      },
                      child: const Text(
                        "시작하기",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: meinbut),
                  minWidth: 100,
                  height: 50,
                )
              ],
            )));
  }
}

class IconPar extends StatelessWidget {
  IconPar({Key? key, required this.name, required this.onTab, required this.radious}) : super(key: key);
  final String name;
  final VoidCallback onTab;
  final double radious;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radious * 2,
      child: Hero(
          tag: name,
          child: Material(color: Colors.transparent, child: InkWell(onTap: onTab, child: CircleAvatar(backgroundImage: AssetImage(name), radius: radious)))),
    );
  }
}

class PrebysterianAndLiberalPage extends StatelessWidget {
  const PrebysterianAndLiberalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle meinbut =
        ElevatedButton.styleFrom(primary: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), elevation: 10.0);
    const TextStyle titleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 24.0, fontWeight: FontWeight.bold);
    const TextStyle subTitleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 18.0, fontWeight: FontWeight.bold);
    const TextStyle mainTextStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 2.0,
      fontSize: 10.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("신학 성향 측정기"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconPar(
                      name: "aaa/Presbyterian.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                  const Text(" 자유주의 - 전통주의 ", style: titleTextStyle),
                  IconPar(
                      name: "aaa/Liberian.jpg",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                ],
              ),
              const Divider(thickness: 0.5, color: Colors.grey),
              const Text("자유주의 신학", style: subTitleTextStyle),
              const Text(
                  " 자유주의 신학은 18세기 이후 계몽주의의 영향을 받아 나타난 일련의 신학 사조이다. 자유주의는 하나님의 말씀을 인간의 사고를 통해 이해하고 그 의미와 가치 나아가 성경의 형성 배경과 과정까지 학문적 방법으로 해석하고자 했다. 자유주의 신학은 어떤 단일 신학 계통이 아니며 다양한 특성이 나타날 수 있다. 대표적인 자유주의 신학자는 F.D.E. Schleiermacher, Albrecht Ritschl, Karl Barth, Paul Tilich, H.W.Frei가 있다..",
                  style: mainTextStyle),
              const Text(" 자유주의 신학이 여러 초점과 논증을 가지고 있으므로, 자유주의가 나타내는 바를 하나로 정리할 수 없다. 그렇지만 성경에 대한 새로운 이해, 인간에 대한 상황적 분석 나아가 세상에 대한 새로운 가치판단을 제공해준다.",
                  style: mainTextStyle),
              const SizedBox(
                height: 5,
              ),
              const Text("전통주의 신학", style: subTitleTextStyle),
              const Text(
                  " 전통주의 신학, 또는 복음주의 신학은 원래 16세기 종교개혁자들의 신학과 연관이 깊지만, 전통주의적 방식은 자유주의에 대한 반작용으로 나타났다. 그들은 성서 자체의 신학, 특히 복음에 대한 이해를 기준으로 한 기본적인 신념들을 고수한 일련의 신학들을 뜻한다. 대표적인 신학자로는 Charles Hodge, Herman Bavink, Helmut Thielicke, G.C. Berkouwer가 있다.",
                  style: mainTextStyle),
              const Text(" 전통주의 신학은 일반적으로 성경 그 자체에 대한 이해와 신학을 기반으로 논증한다. 그러므로 교의학에 대한 백과사전식 서술, 성경의 권위에 대한 호소, 구원의 인격적 채험의 강조와 함께 성경에 대한 합리적, 이성적 비평을 반대한다.",
                  style: mainTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class PietismAndAntiPietismPage extends StatelessWidget {
  const PietismAndAntiPietismPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle meinbut =
        ElevatedButton.styleFrom(primary: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), elevation: 10.0);
    const TextStyle titleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 24.0, fontWeight: FontWeight.bold);
    const TextStyle subTitleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 18.0, fontWeight: FontWeight.bold);
    const TextStyle mainTextStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 2.0,
      fontSize: 10.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("신학 성향 측정기"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconPar(
                      name: "aaa/Pietism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                  const Text(" 신앙주의 - 지식주의 ", style: titleTextStyle),
                  IconPar(
                      name: "aaa/antiPietism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                ],
              ),
              const Divider(thickness: 0.5, color: Colors.grey),
              const Text("대충 신앙주의 신학", style: subTitleTextStyle),
              const Text("신앙주의는 경건주의의 모태를 이룹니다. 경건주의는 종교개혁 신학의 교리화와 형식화를 반대해 개인의 경건과 구원 여부에 큰 비중을 둡니다.", style: mainTextStyle),
              const Text("그러므로 신앙을 중요하게 여기는 사람들은, 경건성, 개인의 구원, 그리고 경건한 삶과, 체험, 기적, 은사와 같은 요소를 중요시하고 신도들의 신앙의 척도로 여깁니다.", style: mainTextStyle),
              const SizedBox(
                height: 5,
              ),
              const Text("대충 지식주의 신학", style: subTitleTextStyle),
              const Text("기독교의 신앙이란 곧 구원에 이르는 개념을 이해하고 납득하고 그것에 따라 사는 것으로 여깁니다.", style: mainTextStyle),
              const Text("그러므로 교리와 지식을 중요시하는 사람들은 교회의 형태, 사역 그리고 신자들의 행동이 신학적 해석을 통해 평가하고, 신앙을 조직화해서 이해하는데 탁월합니다.", style: mainTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class PluralismAndAntiPluralismPage extends StatelessWidget {
  const PluralismAndAntiPluralismPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle meinbut =
        ElevatedButton.styleFrom(primary: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), elevation: 10.0);
    const TextStyle titleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 24.0, fontWeight: FontWeight.bold);
    const TextStyle subTitleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 18.0, fontWeight: FontWeight.bold);
    const TextStyle mainTextStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 2.0,
      fontSize: 10.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("신학 성향 측정기"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconPar(
                      name: "aaa/antiPluralism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                  const Text(" 배타주의 - 다원주의 ", style: titleTextStyle),
                  IconPar(
                      name: "aaa/Pluralism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                ],
              ),
              const Divider(thickness: 0.5, color: Colors.grey),
              const Text("대충 배타주의 신학", style: subTitleTextStyle),
              const Text(
                  "배타주의와 다원주의는 다른 종교에 대한 인식에 영향을 미칩니다. 다른 종교에 대해 배타적인 사람들은 기독교가 가지고 있는 진리가 오직 유일한 진리이고, 인간의 성화와 구원에 있어서 반드시 필요한 이해이므로 그것을 독보적인 위치로 승격시키고 타인에게 전파하려 합니다.",
                  style: mainTextStyle),
              const Text("그러므로 배타주의적인 사람은 다른 종교나 관습을 부정하고 종교 간 대결로 이끌어갑니다.", style: mainTextStyle),
              const SizedBox(
                height: 5,
              ),
              const Text("대충 다원주의 신학", style: subTitleTextStyle),
              const Text("이 검사에서 다원주의는 포괄주의까지 모두 포함합니다. 다원주의는 기독교의 진리가 이 세상의 궁극적인 이해라는 것은 동의하지만, 기독교가 전파되지 않은 곳에서 그러한 진리의 이해가 완전히 결여되었다고 생각하지 않습니다.",
                  style: mainTextStyle),
              const Text("그러므로 다원주의적인 사람은 다른 종교나 관습도 그 문화권에서 통용되는 것으로 이해하고, 나아가 그 전통 속 지혜와 교훈을 기독교와 비교하고 영향을 주고 받으려고 합니다.", style: mainTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgessiveAndAntiProgressivePage extends StatelessWidget {
  const ProgessiveAndAntiProgressivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle meinbut =
        ElevatedButton.styleFrom(primary: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), elevation: 10.0);
    const TextStyle titleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 24.0, fontWeight: FontWeight.bold);
    const TextStyle subTitleTextStyle = TextStyle(color: Colors.amber, letterSpacing: 2.0, fontSize: 18.0, fontWeight: FontWeight.bold);
    const TextStyle mainTextStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 2.0,
      fontSize: 10.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("신학 성향 측정기"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconPar(
                      name: "aaa/antiProgessivism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                  const Text(" 비관주의 - 낙관주의 ", style: titleTextStyle),
                  IconPar(
                      name: "aaa/Progessivism.png",
                      onTab: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()));
                      },
                      radious: 30.0),
                ],
              ),
              const Divider(thickness: 0.5, color: Colors.grey),
              const Text("대충 비관주의 신학", style: subTitleTextStyle),
              const Text("비관주의적 경향은 개인 성도가 세계를 어떻게 이해하는지와 영향이 있습니다. 비관주의적인 사람은 이 세계가 전적으로 악하고 불완전하므로 영향을 받지 않고 고립되려고 합니다.", style: mainTextStyle),
              const Text("나아가 최후의 종말, 구원, 그리고 이 세계의 악에 대한 심판을 진지하게 숙고하며 더 나은 내세를 고대합니다. 특징적으로 요한계시록에서 천년 왕국을 미래에 일어날 사건으로 이해합니다.", style: mainTextStyle),
              const SizedBox(
                height: 5,
              ),
              const Text("대충 낙관주의 신학", style: subTitleTextStyle),
              const Text("낙관주의적 경향은 교회가 이 세상에 속하여 이 세계가 완전하게 되었거나, 될 수 있다고 말합니다. 즉 이 세계 자체가 하나님의 뜻이 펼쳐지는 공간이며 구원, 심판, 죽은 후의 세계를 다소 축소합니다.",
                  style: mainTextStyle),
              const Text(
                  "예를 들어서 로마제국 콘스탄티누스의 기독교 공인으로 로마제국을 다시 이해했던 어용신학, 인간 사회가 기독교적 영향을 통해 완전한 사회로 변화할 수 있다고 고려하는 상황신학, 정치신학이 대표적입니다. 특징적으로 요한계시록에서 천년 왕국을 교회 그 자체로 이해하여, 천년 왕국 상태에 있거나 천년 왕국이 일어난 후 심판이 있을 것으로 보는 경향이 있습니다.",
                  style: mainTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
