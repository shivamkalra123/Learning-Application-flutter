import 'package:flutter/material.dart';
import 'package:flutter_application_1/FlashcardScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "What do you want to learn today? 📚",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    List<String> categories = [
                      "Vocabulary",
                      "Grammer",
                      "Words",
                      "Phrases"
                    ];
                    return _buildCard(categories[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FlashcardScreen(category: text),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black45,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
