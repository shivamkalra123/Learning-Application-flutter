import 'package:flutter/material.dart';
import 'package:flutter_application_1/MyHomePage.dart';
import 'package:flutter_application_1/QuizProvider.dart';
import 'package:provider/provider.dart';
import 'word_match_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordMatchProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WordMatchGame(),
    );
  }
}

class WordMatchGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordMatchProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.areAllPairsSelected()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Language Learning App')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Word Match Game'),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Match the words with their pairs!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: provider.shuffledKeys.length +
                    provider.shuffledValues.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    int leftIndex = index ~/ 2;
                    if (leftIndex < provider.shuffledKeys.length) {
                      String word = provider.shuffledKeys[leftIndex];
                      return GestureDetector(
                        onTap: provider.wordColors[word] != null
                            ? null
                            : () {
                                provider.selectLeftWord(word);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: provider.wordColors[word] ?? Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              word,
                              style: TextStyle(
                                color: provider.wordColors[word] != null
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    int rightIndex = (index - 1) ~/ 2;
                    if (rightIndex < provider.shuffledValues.length) {
                      String pair = provider.shuffledValues[rightIndex];
                      return GestureDetector(
                        onTap: provider.wordColors[pair] != null
                            ? null
                            : () {
                                provider.selectRightWord(pair);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: provider.wordColors[pair] ?? Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              pair,
                              style: TextStyle(
                                color: provider.wordColors[pair] != null
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return SizedBox
                      .shrink(); // Return an empty widget for invalid indexes
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.resetPairs();
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
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
      ),
      body: Center(
        child: Text('This is the new exercise screen.'),
      ),
    );
  }
}
