

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/personLoader.dart';

import 'locationLoader.dart';

class PersonDetailsPage extends StatefulWidget{
  PersonDetailsPage({required this.id}) : super();

  final int id;

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsPage>{
  _State({required this.id}) : super();

  int id;
  PersonDetails? person;
  LocationDetails? location;
  Image? img;

  @override
  void initState(){
    super.initState();
    loadData();
  }

  void loadData() async {
    var personInfo = await loadPerson(id);
    var locationInfo = await loadLocation(id);
    setState((){
      person = personInfo;
      location = locationInfo;
    });

    setState((){
      if(person != null){
        img = Image.network(
          person!.avatar,
          width: double.infinity,
        );
      }
    });
  }

  BorderSide getBorderSide(bool flag){
    if(flag == true){
      return BorderSide(
          color: Colors.black,
          width: 3.0
      );
    }

    return BorderSide(
        color: Colors.white,
        width: 0
    );
  }
  
  Widget getTextWidget(String text, bool flag){
    return Flexible(
        child: Container(
          width: 1000,
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.black,
                    width: 3.0

                ),
                top: getBorderSide(flag),
              )
          ),
          margin: new EdgeInsets.all(0),
          padding: new EdgeInsets.all(10),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if ((person == null) || (location == null) || (img == null)) {
      widget = Center(child: Text("Please, wait..."));
    }else{
      widget = SafeArea(
          child: Column(
            children: [
              GestureDetector(
                child: img,
              ),
              Container(
                margin: new EdgeInsets.fromLTRB(0, 0, 0, 10),
                padding: new EdgeInsets.all(10),
                child: Text(
                  "Location",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              getTextWidget("Name: " + location!.name, true),
              getTextWidget("Type: " + location!.type, false),
              getTextWidget("Dimension: " + location!.type, false),
              getTextWidget("Created: " + location!.created, false),
            ],
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Person details"),
      ),
      body: widget
    );
  }
}