import 'package:flutter/material.dart';
import 'quiz_brain.dart';


void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}



QuizBrain quizBrain = QuizBrain();

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == false) {
        quizBrain.addAnswer(userPickedAnswer == correctAnswer);
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check,color: Colors.green,));
        } else {
          scoreKeeper.add(Icon(Icons.close,color: Colors.red,));
        }
        quizBrain.nextQuestion();

      } 
      //else {
      //  quizBrain.reset();
      //  scoreKeeper = [];
      //}
    });
  }

  void reset(){
    setState(() {
      quizBrain.reset();
      quizBrain.resetAnswers();
      scoreKeeper = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: quizBrain.isFinished() == false ? 
        <Widget>[

          Expanded(
            flex: 2,
              child: Center(
                child: Text(
                  quizBrain.percentCorretAnswer(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'Certo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  //The user picked true.
                  checkAnswer("Certo");
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'Errado',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //The user picked false.
                  checkAnswer("Errado");
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.yellow,
                child: Text(
                  'Talvez',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //The user picked false.
                  checkAnswer("Talvez");
                },
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ]: 
        <Widget>[
          Text(
                quizBrain.percentCorretAnswer(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
          Expanded(
            child: FlatButton(
              color: Colors.blueGrey,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  reset();
                },
              ),
            ),
          ]
        );
      }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
