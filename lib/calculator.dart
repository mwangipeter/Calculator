import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:math_expressions/math_expressions.dart';
class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //Variables.
  String mathEquation = "0";
  String mathAnswer = "0";
  String expression = "";
  double mathEquationFontSize = 40.0;
  double mathAnswerFontSize = 50.0;
  Color answerColor = Colors.black;

  // GlobalKey is needed to show bottom sheet.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Function for creating the calculator buttons.
  Container myButton(String btnText, Color btnColor) {
    return Container(
      child: TextButton(
        onPressed: () => _onClick(btnText),
        child: Text(
                btnText,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black
                  ),
                ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.black,
                  width: 0.3,
                  style: BorderStyle.solid
              )
          )
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(16.0)
          ),
          backgroundColor: MaterialStateProperty.all<Color>(btnColor),
        ),
      ),
    );
  }
  _onClick(String btnText) {
    setState(() {
      if (btnText == "Hist.") {
        // this
        //     ._scaffoldKey
        //     .currentState
        //     .showBottomSheet((ctx) => showBottomSheet(ctx));
        showBottomSheet();
        //print(mathEquation.substring(mathEquation.length - 1));
      }
      else if (btnText == "C") {
        mathEquationFontSize = 40;
        mathAnswerFontSize = 50;
        mathEquation = "0";
        mathAnswer = "0";
        answerColor = Colors.black;
      }
      else if (btnText == "⌫") {
        mathEquationFontSize = 50;
        mathAnswerFontSize = 40;
        mathEquation = mathEquation.substring(0, mathEquation.length - 1);
        if(mathEquation == "") {
          mathEquation = "0";
        }
      }
      else if (btnText == "=") {
        mathEquationFontSize = 38.0;
        mathAnswerFontSize = 48.0;

        expression = mathEquation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          mathAnswer = '${exp.evaluate(EvaluationType.REAL, cm)}';
          answerColor = Colors.black;
        }catch(e){
          mathAnswer = "Error";
          answerColor = Colors.red;
        }
      }
      else if (((btnText == ("+")) || (btnText == ("-")) || (btnText == ("×")) || (btnText == ("÷"))) && ( (mathEquation.substring(mathEquation.length - 1) == "+") || (mathEquation.substring(mathEquation.length - 1) == "-") || (mathEquation.substring(mathEquation.length - 1) == "×") || (mathEquation.substring(mathEquation.length - 1) == "÷"))) {

      }
      else {
        mathEquationFontSize = 50.0;
        mathAnswerFontSize = 40.0;
        if (mathEquation == "0") {
          mathEquation = btnText;
        } else {
          mathEquation = mathEquation + btnText;
        }
        answerColor = Colors.black;
        mathAnswer = "0";
      }
    });
  }
void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.blue,
                  ),
                ],
              )
          );
        },
    );
}
  // Widget buildBottomSheet(BuildContext context) {
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: Text("Simple Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          //This container will contain the equation
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
                    mathEquation,
                    style: TextStyle(
                        fontSize: mathEquationFontSize
                    ),
                  ),
          ),
          //This container will contain the answer
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
                    mathAnswer,
                    style: TextStyle(
                        fontSize: mathAnswerFontSize,
                        color: answerColor,
                    ),
                  ),
          ),
          Expanded(
              child: Divider()
          ),
          //The buttons are displayed n this container.
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.5,
            //Staggered grid view - Chosen because the = button is not equal to the others.
            child: StaggeredGridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: <Widget>[
                myButton("Hist.", Colors.grey[300]),
                myButton("C", Colors.grey[300]),
                myButton("⌫", Colors.grey[300]),
                myButton("÷", Colors.grey[300]),

                myButton("7", Colors.white),
                myButton("8", Colors.white),
                myButton("9", Colors.white),
                myButton("×", Colors.grey[300]),
                
                myButton("4", Colors.white),
                myButton("5", Colors.white),
                myButton("6", Colors.white),
                myButton("-", Colors.grey[300]),
                
                myButton("1", Colors.white),
                myButton("2", Colors.white),
                myButton("3", Colors.white),
                myButton("+", Colors.grey[300]),

                myButton(".", Colors.white),
                myButton("0", Colors.white),
                myButton("=", Colors.blue),
              ],
              //Setting the width and height of every button.
              staggeredTiles: [
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),

                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),

                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),

                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.1 * 1),
                StaggeredTile.extent(2, MediaQuery.of(context).size.height * 0.1 * 1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
