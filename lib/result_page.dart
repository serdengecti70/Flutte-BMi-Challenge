import "package:flutter/material.dart";

const bottomContainerHeight = 80.0;
const bottomContainerColor = Color(0xFFEB1555);
const activeBoxColor = Color(0xFF1D1E33);

class ResultPage extends StatelessWidget {

  //final String ResultPageid = "/resultPage";

  final String bmiResult;
  final String resultText;
  final String interpretation;

  ResultPage({@required this.bmiResult,@required this.resultText, @required this.interpretation});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI CALCULATOR"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                  "YOUR RESULT",
                  style: TextStyle(color: Colors.white, fontSize: 50.0),
                )),
              )),
          Expanded(
            flex: 5,
            child: BmiBox(
              color: activeBoxColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(resultText),
                  Text(bmiResult),
                  Text(interpretation),
                ],
              ),
            ),
          ),
          Container(
            color: bottomContainerColor,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomContainerHeight,
            child: MaterialButton(
                child: Text("RE-CALCULATE"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}

class BmiBox extends StatelessWidget {
  BmiBox({@required this.color, this.cardChild});

  final Color color;
  final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardChild,
    );
  }
}
