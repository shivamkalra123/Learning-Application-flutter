import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'QuizProvider.dart';

class Quizscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Exercise'),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          var currentQuestion = provider.kbcData[provider.currentQuestionIndex];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion["question"],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ...currentQuestion["options"].map<Widget>((option) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: provider.answered
                          ? null
                          : () => provider.checkAnswer(option, context),
                      child: Text(option),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: provider.answered
                            ? (option == currentQuestion["answer"]
                                ? Colors.green
                                : option == provider.selectedOption
                                    ? Colors.red
                                    : Colors.grey)
                            : Colors.blue,
                        minimumSize: Size(double.infinity, 50),
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 20.0),
                if (provider.answered)
                  ElevatedButton(
                    onPressed: () {
                      if (provider.currentQuestionIndex <
                          provider.kbcData.length - 1) {
                        provider.nextQuestion(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewExerciseScreen()),
                        );
                      }
                    },
                    child: Text("Next"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NewExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exercise'),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Center(
        child: Text(
          'This is the new exercise screen.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
