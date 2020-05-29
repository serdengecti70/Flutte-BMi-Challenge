import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "result_page.dart";
import 'bmi_calculator.dart';

const bottomContainerHeight = 80.0;
const bottomContainerColor = Color(0xFFEB1555);
const activeBoxColor = Color(0xFF1D1E33);
const inactiveBoxColor = Color(0xFF111328);

var pressChecked = true;

enum Gender { male, female }

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bmi App",
      debugShowCheckedModeBanner: false,
      home: InputPage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF121223),
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;

  var userLength = 180.0;

  var userWeight = 0;

  var userAge = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                BmiBox(
                  color: selectedGender == Gender.male
                      ? activeBoxColor
                      : inactiveBoxColor,
                  cardChild: GenderCard(
                    genderString: "MALE",
                    icon: FontAwesomeIcons.mars,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                  ),
                ),
                BmiBox(
                  color: selectedGender == Gender.female
                      ? activeBoxColor
                      : inactiveBoxColor,
                  cardChild: GenderCard(
                    genderString: "FEMALE",
                    icon: FontAwesomeIcons.venus,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          BmiBox(
            color: activeBoxColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${userLength.toInt()}"),
                SizedBox(
                  height: 10.0,
                ),
                Text("HEIGHT"),
                SizedBox(
                  height: 10.0,
                ),
                Slider(
                  value: userLength,
                  min: 60.0,
                  max: 250.0,
                  onChanged: (value) {
                    setState(() {
                      userLength = value;
                    });
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                //WEIGHT
                BmiBox(
                  color: activeBoxColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("WEIGHT"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("$userWeight"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardIconButton(
                            icondata: Icons.add,
                            onpressed: () {
                              setState(() {
                                userWeight++;
                              });
                            },
                          ),
                          CardIconButton(
                            icondata: Icons.remove,
                            onpressed: () {
                              setState(() {
                                userWeight--;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //AGE
                BmiBox(
                  color: activeBoxColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ///AGE
                      Text("AGE"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("$userAge"),
                      SizedBox(
                        height: 8.0,
                      ),

                      ///ICONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CardIconButton(
                            icondata: Icons.add,
                            onpressed: () {
                              setState(() {
                                userAge += 1;
                              });
                            },
                          ),
                          CardIconButton(
                            icondata: Icons.remove,
                            onpressed: () {
                              setState(() {
                                userAge--;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //RESULT Button
          Container(
            color: bottomContainerColor,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomContainerHeight,
            child: MaterialButton(
                child: Text("CALCULATE"),
                onPressed: () {
                  Calculator calc = Calculator(
                    height: userLength.toInt(),
                    weight: userWeight,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ResultPage(
                              bmiResult: calc.calculateBMI(),
                              resultText: calc.getResult(),
                              interpretation: calc.getInterpretation())));
                }),
          ),
        ],
      ),
    );
  }
}

class CardIconButton extends StatelessWidget {
  CardIconButton({this.icondata, this.onpressed});

  final Function onpressed;
  final IconData icondata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        heroTag: null,
        child: Icon(icondata),
        onPressed: onpressed,
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  GenderCard({this.genderString, this.icon, this.onTap});

  final String genderString;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 80.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            genderString,
            style: TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98)),
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
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}

//Color(0xFF1D1E33)
