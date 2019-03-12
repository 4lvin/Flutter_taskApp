import 'package:flutter/material.dart';
import 'package:plan_task/src/blocs/task_bloc.dart';
import 'package:intl/intl.dart';


class AddTask extends StatefulWidget {
AddTask({this.email});
final String email;
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTime _dueDate = new DateTime.now();
  String _dateText= '';
  String _title ='';
  String _note ='';
  String _level='';

  Future<Null> _selectDueDate(BuildContext context) async{
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2050)
    );
    if(picked != null){
      setState(() {
        //new DateFormat('yyy-MMMM-dd').format(picked) ;
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
  }
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black87
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Add Task', style: new TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  letterSpacing: 2.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String str){
                setState(() {
                  _title = str;
                });
              } ,
              decoration: new InputDecoration(
                icon: Icon(Icons.dashboard),
                hintText: 'New Task',
                border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(
                  child: Text("Due Date",style: TextStyle(fontSize: 22.0,color: Colors.black54))),
                new FlatButton(
                  onPressed: ()=> _selectDueDate(context),

                  child: Text(_dateText, style: TextStyle(fontSize: 22.0, color: Colors.black54)))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String str){
                setState(() {
                  _note = str;
                });
              } ,
              decoration: new InputDecoration(
                icon: Icon(Icons.note),
                hintText: 'Note',
                border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String str){
                setState(() {
                  _level = str;
                });
              } ,
              decoration: new InputDecoration(
                icon: Icon(Icons.linear_scale),
                hintText: 'Level',
                border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:70.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              IconButton(
                icon: Icon(Icons.check, size: 40.0,),
                onPressed: (){
                  
                  bloc.addSaveTask(_title, _dueDate.toIso8601String(), _note, _level, widget.email);
                  Navigator.pop(context);
                },
              ),
               IconButton(
                icon: Icon(Icons.close, size: 40.0,),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],),
          )
        ],
      ),
    );
  }
}