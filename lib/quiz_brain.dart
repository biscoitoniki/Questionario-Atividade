import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List _questionsAnswer = [];


  List<Question> _questionBank = [
    Question('Existe vida em marte', 'Talvez'),
    Question('2+2 = 4', 'Certo'),
    Question('A mula sem cabeça tem Cabeça', 'Errado'),
    Question('Chocolate tem um gosto muito bom.', 'Certo'),
 ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  String getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  void addAnswer(bool validate){
    _questionsAnswer.add(validate);
  }

  String percentCorretAnswer(){
    var contador = 0;
    for (var andador in _questionsAnswer){
      if( andador == true){
        contador++;
      }
    }

    var resposta;
    if(contador == 0){
      resposta = 0;
    }
    else{
      resposta = (contador/_questionBank.length)*100;
    }
    return double.parse((resposta).toStringAsFixed(2)).toString() + "%";
  }

  void resetAnswers(){
    _questionsAnswer = [];
  }

  bool isFinished() {
    if (_questionNumber > _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
