import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class QuizProvider extends ChangeNotifier {
  List<Map<String, dynamic>> kbcData = [
    {
      "question": "Wie spät ist es?",
      "options": [
        "What time is it?",
        "Where are you going?",
        "How far is it?",
        "What is your name?"
      ],
      "answer": "What time is it?"
    },
    {
      "question": "Wie geht es Ihnen?",
      "options": [
        "What is your favorite color?",
        "How are you?",
        "Where do you work?",
        "When is your birthday?"
      ],
      "answer": "How are you?"
    },
  ];

  int currentQuestionIndex = 0;
  bool answered = false;
  String selectedOption = '';

  void checkAnswer(String option, BuildContext context) {
    answered = true;
    selectedOption = option;
    notifyListeners();

    String message;
    if (option == kbcData[currentQuestionIndex]["answer"]) {
      message = "Correct! Well done.";
    } else {
      message =
          "Incorrect. The correct answer is: ${kbcData[currentQuestionIndex]["answer"]}";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Answer"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                nextQuestion(context);
              },
              child: Text("Next"),
            ),
          ],
        );
      },
    );
  }

  void nextQuestion(BuildContext context) {
    if (currentQuestionIndex < kbcData.length - 1) {
      currentQuestionIndex++;
      answered = false;
      selectedOption = '';
      notifyListeners();
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WordMatchGame()));
    }
  }
}
