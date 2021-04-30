import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_result.dart';
import 'package:quiz_app/widget/widget_candidates.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen({this.quizs});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //정답을 담아놓는 리스트
  List<int> _answers = [-1, -1, -1];
  //선택지가 선택되었는지 기록하는 리스트
  List<bool> _answerState = [false, false, false, false];
  //어떤 문제를 보고 있는지
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.6,
            child: Swiper(
              controller: _controller,
              //Swipe 모션을 틍해 넘어가지 않음(퀴즈 스킵을 막음)
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: width * 0.024, bottom: width * 0.024),
            child: Text(
              'Q${(_currentIndex + 1).toString()}.',
              style: TextStyle(
                  fontSize: width * 0.06, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012, bottom: width * 0.036),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: width * 0.048, fontWeight: FontWeight.bold),
            ),
          ),
          //이후에 배치될 childrean들이 아래에서부터 배치되록하는 효과
          Expanded(child: Container()),
          Column(children: _buildCandidates(width, quiz)),
          Container(
            constraints: BoxConstraints(minWidth: width * 0.5),
            height: 40,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white),
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                //문제 수에 따라 text 변경
                child: _currentIndex == widget.quizs.length - 1
                    ? Text('결과보기')
                    : Text('다음문제'),
                // 정답을 선택함에 따라 버튼이 켜짐(-1은 초기 상태)
                onPressed: _answers[_currentIndex] == -1
                    ? null
                    : () {
                        // 마지막 문제일 때
                        if (_currentIndex == widget.quizs.length - 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                      answers: _answers,
                                      quizs: widget.quizs,
                                    )),
                          );
                        }
                        // 마지막 문제가 아닐 때
                        else {
                          //보기에 체크된 것들을 없앰
                          _answerState = [false, false, false, false];
                          //문제 번호 증가
                          _currentIndex += 1;
                          //다음 문제로 넘어감
                          _controller.next();
                        }
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _childrean = [];
    for (int i = 0; i < 4; i++) {
      _childrean.add(
        CandiWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                //선택된 것은 true
                if (j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                } else {
                  //선택되지 않은 것들은 false
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      _childrean.add(Padding(padding: EdgeInsets.all(width * 0.024)));
    }
    return _childrean;
  }
}
