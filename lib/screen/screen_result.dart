import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_home.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;

  ResultScreen({this.answers, this.quizs});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    // 총 점수
    int score = 0;
    // 사용자가 입력한 답과 정답과 비교 후
    for (int i = 0; i < quizs.length; i++) {
      // 정답이라면 점수 + 1
      if (quizs[i].answer == answers[i]) {
        score += 1;
      }
    }
    // WillPopScope를 이용해서 뒤로가기가 적용되지 않게 함
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.deepPurple),
                  color: Colors.deepPurple),
              width: width * 0.85,
              height: height * 0.6,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: width * 0.048)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.deepPurple),
                        color: Colors.white),
                    width: width * 0.73,
                    height: height * 0.4,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: width * 0.048, bottom: width * 0.048),
                          child: Text(
                            '수고하셨습니다!',
                            style: TextStyle(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '당신의 점수는',
                          style: TextStyle(
                              fontSize: width * 0.048,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          '${score.toString()}/${quizs.length.toString()}',
                          style: TextStyle(
                              fontSize: width * 0.21,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Padding(padding: EdgeInsets.all(width * 0.012)),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                    child: Container(
                      constraints: BoxConstraints(minWidth: width * 0.73),
                      height: height * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          primary: Colors.white,
                        ),
                        child: Text(
                          '홈으로 돌아가기',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
