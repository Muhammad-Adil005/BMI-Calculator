import 'package:flutter/material.dart';

String _finalResult = "";
String _resultReading = "";

double inches = 0.0;
double result = 0.0;
final TextEditingController _ageController = TextEditingController();
final TextEditingController _heightController = TextEditingController();
final TextEditingController _weightController = TextEditingController();

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("BMI")),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: EdgeInsets.all(2.0),
          children: [
            Image.asset(
              "images/bmilogo.png",
              height: 80.0,
              width: 80.0,
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Age',
                        hintText: 'e.g: 34',
                        icon: Icon(Icons.person_outline)),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Height in feet',
                        //hoverColor: Colors.grey,
                        hintText: 'e.g 6.5',
                        icon: Icon(Icons.insert_chart)),
                  ),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Weight in lbs',
                        hintText: 'e.g 180',
                        icon: Icon(Icons.line_weight)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Please let us know your gender:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      ListTile(
                        leading: Radio<String>(
                          activeColor: Colors.red,
                          value: 'male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: Text('Male'),
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: Text('Female'),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        alignment: Alignment.topCenter,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute()));
                            setState(() {
                              int age = int.parse(_ageController.text);
                              double height =
                                  double.parse(_heightController.text);
                              inches = height * 12;
                              double weight =
                                  double.parse(_weightController.text);

                              if ((_ageController.text.isNotEmpty || age > 0) &&
                                  ((_heightController.text.isNotEmpty ||
                                          inches > 0) &&
                                      (_weightController.text.isNotEmpty ||
                                          weight > 0))) {
                                result = weight / (inches * inches) * 703;

                                if (double.parse(result.toStringAsFixed(1)) <
                                    18.5) {
                                  _resultReading = "UnderWeight";
                                  print(_resultReading);
                                } else if (double.parse(
                                            result.toStringAsFixed(1)) >=
                                        18.5 &&
                                    result < 25) {
                                  _resultReading = "Great Shape!";
                                  print(_resultReading);
                                } else if (double.parse(
                                            result.toStringAsFixed(1)) >=
                                        25.0 &&
                                    result < 30) {
                                  _resultReading = "OverWeight";
                                } else if (double.parse(
                                        result.toStringAsFixed(1)) >=
                                    30.0) {
                                  _resultReading = "Obese";
                                }
                              } else {
                                result = 0.0;
                              }
                            });

                            _finalResult =
                                "Your BMI : ${result.toStringAsFixed(1)}";
                          },
                          color: Colors.pinkAccent,
                          child: Text('Calculate'),
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

void calculateBMI() {}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_finalResult",
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 29.9,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
          Text(
            "$_resultReading ",
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25.9,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
          RaisedButton(
            color: Colors.pinkAccent,
            child: Text('Re-Calculate'),
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
