

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
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (person == null) {
      widget = Center(child: Text("Please, wait..."));
    } else if ((person != null) && (location == null)) {
      widget = SafeArea(
          child: Column(
        children: [
          GestureDetector(
            child: Image.network(
              person!.avatar,
              width: double.infinity,
            ),
          ),
          Text("Please, wait..."),
        ],
      ));
    }else{
      widget = SafeArea(
          child: Column(
            children: [
              GestureDetector(
                child: Image.network(
                  person!.avatar,
                  width: double.infinity,
                ),
              ),
              Text("Name: " + location!.name +
                  "\n" +
                  "Type: " + location!.type +
                  "\n" +
                  "Dimension: " + location!.dimension +
                  "\n" +
                  "Location: " + location!.created),
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