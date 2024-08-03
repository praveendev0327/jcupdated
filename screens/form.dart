// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Custom Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _createInputElement();
  }

  void _createInputElement() {
    // final inputElement = html.InputElement()
    //   ..style.border = '1px solid #ccc'
    //   ..style.padding = '10px'
    //   ..style.fontSize = '16px'
    //   ..placeholder = 'Enter text';
    //
    // inputElement.onFocus.listen((_) {
    //   inputElement.select();
    // });
    //
    // html.document.getElementById('input-container')?.append(inputElement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web Custom Input Example'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 60,
          alignment: Alignment.center,
          child:SizedBox()
          // HtmlElementView(viewType: 'input-container'),
        ),
      ),
    );
  }
}