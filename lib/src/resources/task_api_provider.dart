import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/task_model.dart';

class TaskApiProvider{
  Client client = Client();
   String url = "http://31.220.55.149:8095/task";
  Future<PlanModel> fetchTaskList() async{
    print("Entered");
    final list = await client.get("$url/");
    print(list.body.toString());
    if(list.statusCode==200){
      return PlanModel.fromJson(json.decode(list.body));
    }else{
      throw Exception('Failed to load get');
    }
  }
  Future addTask(String title,String date, String note, String level,String email)async{
    print(title);
    print(date);
    print(note);
    print(level);
    print(email);
    var body = jsonEncode({ 'duedate' : date,
      'email' : email,
      'note' : note,
      'title' : title,
      'level' : level});
    final save = await client.post("$url/", headers: {"Content-Type": "application/json"}, body: body);
    if(save.statusCode == 200){
      return save;
    }else
    throw Exception('Failed to load post');
  }
}