import 'package:flutter/material.dart';

class CandiWidget extends StatefulWidget {
  //부모 위젯에서 지정한 onTap을 전달하는 기능
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;

  CandiWidget({this.tap, this.text, this.index, this.width, this.answerState});

  @override
  _CandiWidgetState createState() => _CandiWidgetState();
}

class _CandiWidgetState extends State<CandiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(widget.width * 0.048, widget.width * 0.024,
          widget.width * 0.048, widget.width * 0.024),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.deepPurple),
          //선택됨에 따라 색깔 변경
          color: widget.answerState ? Colors.deepPurple : Colors.white),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.width * 0.035,
              color: widget.answerState ? Colors.white : Colors.black),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            widget.answerState = !widget.answerState;
          });
        },
      ),
    );
  }
}
