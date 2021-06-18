import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/personWidget.dart';

import 'dataLoader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person>? persons;
  Exception? error;

  void loadData() async{
    try{
      var data = await loadPersons();
      setState(() {
        this.persons = data;
      });
    } on Exception catch(exception){
      setState((){
        this.error = exception;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }

  Widget personsList(BuildContext context, List<Person> data){
    return ListView.builder(
      itemCount: persons!.length,
      itemBuilder: (context, index) => Row(
        children: [
          IconButton(onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailsPage(id: data[index].id)))
          }, icon: Icon(Icons.person)),
          Flexible(
              child: Container(
          padding: new EdgeInsets.only(right: 13.0),
            child: Text(
              persons![index].id.toString() +
                  " " +
                  persons![index].name +
                  " " +
                  persons![index].status,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget loader(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Load data ...',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  Widget exceptionStub(BuildContext context, Exception exception){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Oops! Error is ${exception.toString()}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    final List<Person>? currentPersons = persons;
    final Exception? currentException = error;

    if(currentPersons != null){
      content = personsList(context, currentPersons);
    }else if(currentException != null){
      content = exceptionStub(context, currentException);
    }else{
      content = loader(context);
    }

    return Scaffold(
      body: Center(
        child: content
      )
    );
  }
}
