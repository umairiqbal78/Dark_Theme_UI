import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DarkLightTheme();
  }
}

class DarkLightTheme extends StatefulWidget {
  const DarkLightTheme({Key key}) : super(key: key);

  @override
  _DarkLightThemeState createState() => _DarkLightThemeState();
}

ThemeData _lightTheme = ThemeData(
  accentColor: Colors.grey,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
);
ThemeData _darkTheme = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber);  
bool _light = true;

class _DarkLightThemeState extends State<DarkLightTheme> {
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size(80, 60),
      textStyle: const TextStyle(
        fontSize: 30,
      ),
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      shadowColor: Colors.transparent);
  var operStyle = TextStyle(color: Colors.green);
  var numStyle = TextStyle(color: Colors.grey);
  
  var result = "";
  Widget btn(var textt, var btnstyle) {
    return ElevatedButton(
      style: style,
      onPressed: () {
        setState(() {
          result = result + textt;
        });
      },
      child: Text(
        textt,
        style: btnstyle,
      ),
    );
  }

  clearr() {
    setState(() {
      expression = "";
      result = "";
    });
  }

  dynamic expression = "";
  output() {
    Parser p = Parser();
    expression = result;
    Expression exp = p.parse(result);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    

    setState(() {
      result = eval.toString();
      expression = expression;

    });
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: _light ? _lightTheme: _darkTheme,
        title: 'Calculator',
        home: Scaffold(
          appBar: AppBar(
            title: Text("Calculator"),
            actions: [
              Switch(
                  value: _light,
                  onChanged: (state) {
                    setState(() {
                      _light = state;
                    });
                  })
            ],
          ),
          body: Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(expression,
              style: TextStyle(
                fontSize: 36,
                color : Colors.grey,
              )),
          Text(result,
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              btn("1", numStyle),
              btn("2", numStyle),
              btn("3", numStyle),
              btn("/", operStyle)
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              btn("4", numStyle),
              btn("5", numStyle),
              btn("6", numStyle),
              btn("*", operStyle),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              btn("7", numStyle),
              btn("8", numStyle),
              btn("9", numStyle),
              btn("+", operStyle),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              ElevatedButton(
                  style: style,
                  onPressed: clearr,
                  child: Text(
                    "AC",
                    style: TextStyle(color: Colors.grey),
                  )),
              btn("0", numStyle),
              ElevatedButton(
                  style: style,
                  onPressed: output,
                  child: Text(
                    "=",
                    style: TextStyle(color: Colors.green),
                  )),
              btn("-", operStyle),
            ],
          ),
        ],
      ),
    ),
        ));
  }
}
