import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위해 선언
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    // SafeArea로 기기의 상단 노티부분과 하단 영역을 침범하지 않게 영역을 잡아줌
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Quiz App'),
          backgroundColor: Colors.deepPurple,
          // 뒤로가기 버튼을 지우는 효과가 있기 때문에 비워둠
          leading: Container(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Image.asset(
                  'images/quiz.jpg',
                  width: width * 0.8,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(width * 0.024)),
            Text(
              '플러터 퀴즈 앱',
              style: TextStyle(
                  fontSize: width * 0.065, fontWeight: FontWeight.bold),
            ),
            Text(
              '퀴즈를 풀기 전 안내사항입니다.\n꼼꼼히 읽고 퀴즈 풀기를 눌러주세요.',
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(width * 0.048)),
            _buildStep(width, '1. 랜덤으로 나오는 퀴즈를 풀어보세요.'),
            _buildStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤\n다음 문제 버튼을 눌러주세요.'),
            _buildStep(width, '3. 만점을 향해 도전해보세요!'),
            Padding(padding: EdgeInsets.all(width * 0.048)),
            // Container(
            //   padding: EdgeInsets.only(bottom: width * 0.036),
            //   child: Center(
            //     child: ButtonTheme(
            //       minWidth: width * 0.8,
            //       height: height * 0.05,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0)),
            //       child: RaisedButton(
            //         child:
            //             Text('지금 퀴즈 풀기', style: TextStyle(color: Colors.white)),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(minWidth: width * 0.8),
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child:
                        Text('지금 퀴즈 풀기', style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 안내사항
  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.048, width * 0.024, width * 0.048, width * 0.024),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(padding: EdgeInsets.only(right: width * 0.024)),
          Text(title)
        ],
      ),
    );
  }
}