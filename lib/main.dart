import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

// class StdCalc extends StatefulWidget {
//   const StdCalc({Key? key}) : super(key: key);
//   static String pageTitle = "Standard";

//   @override
//   State<StdCalc> createState() => _StdCalcState();
// }

// class _StdCalcState extends State<StdCalc> {
//   TextEditingController input = TextEditingController();
//   var output = "";

//   String _formattedText(String str) {
//     if (str.contains("\u00d7")) {
//       return str.replaceAll("\u00d7", "*");
//     } else if (str.contains("\u2013")) {
//       return str.replaceAll("\u2013", "-");
//     } else if (str.contains("÷")) {
//       return str.replaceAll("÷", "/");
//     } else {
//       return str;
//     }
//   }

//   void _doMaths(val) {
//     if (val == "C") {
//       setState(() {
//         input.clear();
//         output = "";
//       });
//     } else if (val == "=") {
//       if (input.text.isNotEmpty) {
//         var userinput = input.text;
//         userinput = _formattedText(input.text.replaceAll("", ""));
//         Parser P = Parser();
//         try {
//           Expression expression = P.parse(userinput);

//           ContextModel cm = ContextModel();
//           var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
//           setState(() {
//             output = finalvalue.toString();
//           });
//           if (output.endsWith(".0")) {
//             setState(() {
//               output = output.substring(0, output.length - 2);
//             });
//           }
//         } on Exception {
//           setState(() {
//             output = "Syntax Error";
//           });
//         }
//       }
//     } else {
//       var valbb = "";
//       if (val == "*") {
//         valbb = "\u00d7";
//       } else if (val == "-") {
//         valbb = "\u2013";
//       } else if (val == "/") {
//         valbb = "÷";
//       } else {
//         valbb = val;
//       }

//       setState(() {
//         input.value = TextEditingValue(
//           text: input.text
//               .replaceRange(input.selection.start, input.selection.end, valbb),
//           selection: TextSelection.collapsed(
//               offset: input.selection.baseOffset + valbb.length),
//         );
//       });
//     }
//   }

//   void _bkspc() {
//     if (input.text.isNotEmpty) {
//       setState(() {
//         input.text = input.text.substring(0, input.text.length - 1);
//       });
//     } else {
//       setState(() {
//         input.clear();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       input.value =
//           const TextEditingValue(selection: TextSelection.collapsed(offset: 0));
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     input.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Theme.of(context).colorScheme.secondaryContainer,
//               ),
//               padding: const EdgeInsets.all(8),
//               margin: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextField(
//                     enableSuggestions: false,
//                     autofocus: true,
//                     textAlign: TextAlign.right,
//                     decoration: const InputDecoration(border: InputBorder.none),
//                     controller: input,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.deny(
//                           RegExp(r'[a-z] [A-Z] :$'))
//                     ],
//                     style: const TextStyle(
//                       fontSize: 48,
//                     ),
//                     keyboardType: TextInputType.none,
//                   ),
//                   const Divider(),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     output.toString(),
//                     style: const TextStyle(
//                       fontSize: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: GridView(
//               padding: const EdgeInsets.all(8),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 _buildCalcButton("C", true),
//                 _buildCalcButton("()", true),
//                 _buildCalcButton("%", true),
//                 _buildCalcButton("÷", true),
//                 _buildCalcButton("7", false),
//                 _buildCalcButton("8", false),
//                 _buildCalcButton("9", false),
//                 _buildCalcButton("\u00d7", true),
//                 _buildCalcButton("4", false),
//                 _buildCalcButton("5", false),
//                 _buildCalcButton("6", false),
//                 _buildCalcButton("\u2013", true),
//                 _buildCalcButton("1", false),
//                 _buildCalcButton("2", false),
//                 _buildCalcButton("3", false),
//                 _buildCalcButton("+", true),
//                 _buildCalcButton(".", false),
//                 _buildCalcButton("0", false),
//                 FilledButton.tonal(
//                     onPressed: () => _bkspc(),
//                     child: const Icon(
//                       Icons.backspace_outlined,
//                       size: 32,
//                     )),
//                 _buildCalcButton("=", true),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildCalcButton(String val, bool notTonalButton) {
//     var valb;
//     if (val == "\u00d7") {
//       valb = "*";
//     } else if (val == "\u2013") {
//       valb = "-";
//     } else if (val == "÷") {
//       valb = "/";
//     } else {
//       valb = val;
//     }
//     return notTonalButton
//         ? FilledButton(
//             onPressed: () => _doMaths(valb),
//             child: Text(
//               val,
//               style: const TextStyle(
//                 fontSize: 32,
//               ),
//             ),
//           )
//         : FilledButton.tonal(
//             onPressed: () => _doMaths(valb),
//             child: Text(
//               val,
//               style: const TextStyle(
//                 fontSize: 32,
//               ),
//             ),
//           );
//   }
// }

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator_App(),
  ));
}

class Calculator_App extends StatefulWidget {
  const Calculator_App({super.key});

  @override
  State<Calculator_App> createState() => _Calculator_AppState();
}

const operatorcolor = Color(0xff272727);
const buttonColor = Color(0xff191919);
const orangecolor = Color(0xffD9802E);

class _Calculator_AppState extends State<Calculator_App> {
  //Variables
  double firstnumber = 0.0;
  double secondnumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    //if value is AC
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('X', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(31, 169, 165, 165),
        title: Text("Calculator"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //Input and output area
          Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ? '' : input,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ))),
          Row(children: [
            button(
                text: 'AC', buttonBGcolor: operatorcolor, tColor: orangecolor),
            button(
                text: '<', buttonBGcolor: operatorcolor, tColor: orangecolor),
            button(text: '', buttonBGcolor: Colors.transparent),
            button(
                text: '/', buttonBGcolor: operatorcolor, tColor: orangecolor),
          ]),
          Row(children: [
            button(text: '7'),
            button(text: '8'),
            button(text: '9'),
            button(
                text: 'X', tColor: orangecolor, buttonBGcolor: operatorcolor),
          ]),
          Row(children: [
            button(text: '4'),
            button(text: '5'),
            button(text: '6'),
            button(
                text: '-', tColor: orangecolor, buttonBGcolor: operatorcolor),
          ]),
          Row(children: [
            button(text: '1'),
            button(text: '2'),
            button(text: '3'),
            button(
                text: '+', tColor: orangecolor, buttonBGcolor: operatorcolor),
          ]),
          Row(children: [
            button(
                text: '%', tColor: orangecolor, buttonBGcolor: operatorcolor),
            button(text: '0'),
            button(text: '.'),
            button(text: '=', buttonBGcolor: orangecolor),
          ]),
        ],
      ),
    );
  }

// list of buttons
  Widget button({text, tColor = Colors.white, buttonBGcolor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            primary: buttonBGcolor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          )),
    ));
  }
}
