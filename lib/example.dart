import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'data/question_data.dart';
import 'result_screen.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _questionIndex = 0;
  List<Question> _questions = questions;
  List<String?> _userAnswers = List.filled(questions.length, null);

  void _nextQuestion() {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (_questionIndex > 0) {
        _questionIndex--;
      }
    });
  }

  void _saveAnswer(String answer) {
    setState(() {
      _userAnswers[_questionIndex] = answer;
    });
  }

  void _showResults() {
    showResults();
  }

  void showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          questions: _questions,
          userAnswers: _userAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 50, 80),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QUİZ APP',style: TextStyle(color: Colors.orangeAccent),),
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 5, 50,80),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Soru ${_questionIndex + 1}/${_questions.length}',
            style:  const TextStyle(
              color:Colors.white,
              fontSize: 20,
              fontWeight:FontWeight.w600,
              ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            width:double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
               borderRadius: BorderRadius.circular(16),
            ),

          
         child: Text(
            _questions[_questionIndex].question,
            style:  TextStyle(
              color:Color.fromARGB(255, 5, 50, 80),
              fontWeight: FontWeight.w600,
              fontSize: 20),
            textAlign: TextAlign.center,
          ),
          ),
            const SizedBox(height: 10),
          ..._questions[_questionIndex].answers.map((answer) {
            return ElevatedButton(
              onPressed: () {
                _saveAnswer(answer.answer);
                _nextQuestion();
              },
              child: Text(answer.answer,style:TextStyle(color: Color.fromARGB(255, 5, 50, 80)),),
              style:ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent)
            );
          }).toList(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_questionIndex > 0)
                ElevatedButton(
                  onPressed: _prevQuestion,
                  child:  Text('Önceki Soru', style:TextStyle(color:Color.fromARGB(255, 5, 50, 80)),),
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.orangeAccent )
                ),
              if (_questionIndex < _questions.length - 1)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: const Text('Sonraki Soru',style:TextStyle(color:Color.fromARGB(255, 5, 50, 80)),),
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.orangeAccent )

                ),
            ],
          ),
        ],
      ),
    );
  }
}