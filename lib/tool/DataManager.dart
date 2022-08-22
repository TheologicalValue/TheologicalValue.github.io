// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String label;
  final String qid;
  final int value1, value2, value3, value4;

  Question(this.label, this.qid, this.value1, this.value2, this.value3, this.value4);

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': [value1, value2, value3, value4]
    };
  }

  List<int> getValue() {
    return [value1, value2, value3, value4];
  }

  get getQid => qid;
}

class QuestionsCaller {
  List<Question> questions = [];

  Future<List<Question>> questionCall() async {
    await FirebaseFirestore.instance.collection('/questions').get().then((value) {
      for (var element in value.docs) {
        questions.add(Question(element.data()['label'], element.id, element.data()['value'][0], element.data()['value'][1], element.data()['value'][2],
            element.data()['value'][3]));
      }
    });
    return questions;
  }
}
