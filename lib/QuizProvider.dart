import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class QuizProvider extends ChangeNotifier {
  List<Map<String, dynamic>> kbcData = [
    {
      "question": "What is the capital of France?",
      "options": ["Paris", "London", "Berlin", "Madrid"],
      "answer": "Paris"
    },
    {
      "question": "Who wrote 'Hamlet'?",
      "options": ["Shakespeare", "Hemingway", "Faulkner", "Fitzgerald"],
      "answer": "Shakespeare"
    },
    // Add more questions as needed
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
