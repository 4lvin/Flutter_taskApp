import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plan_task/src/auth/auth.dart';
import 'package:plan_task/src/auth/root_page.dart';
import 'package:plan_task/src/ui/add_task.dart';
import '../models/task_model.dart';
import '../blocs/task_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TaskList extends StatefulWidget {
  TaskList({this.user,this.googleSignIn, this.signOut});
  FirebaseUser user;
   GoogleSignIn googleSignIn;
   VoidCallback signOut;

  @override
  _TaskList createState() => _TaskList();
}

class _TaskList extends State<TaskList> {

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    bloc.fetchAllPlans();
//  }


//  @override
//  void dispose() {
//    bloc.fetchAllPlans().dispose();
//  }

  void _signOut() async {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 215.0,
        child: new Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: Text("Sign Out??", style: new TextStyle(fontSize: 16.0)),
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    signOutAccount();
                    widget.signOut();
                    Navigator.pop(context);
                     Navigator.pushReplacementNamed(context, '/rootpage');
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text("Yes"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text("cancel")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPlans();
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new AddTask(email: widget.user.email)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black87,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 2.0,
      //   color: Colors.purple,
      //   child: ButtonBar(children: <Widget>[]),
      // ),
      body: new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: StreamBuilder(
              stream: bloc.allPlans,
              builder: (context, AsyncSnapshot<PlanModel> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            height: 170.0,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black54, boxShadow: [
              new BoxShadow(color: Colors.black, blurRadius: 8.0)
            ]),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: <Widget>[
//                        StreamBuilder(
//                      stream: getSignedInAccount().asStream(),
//                      builder: (BuildContext context,
//                          AsyncSnapshot<FirebaseUser> snapshot) {
//                        if (snapshot.hasData) {
//                          return photoUrl(snapshot);
//                        } else if (snapshot.hasError) {
//                          return Text(snapshot.error.toString());
//                        }
//                      }),
                       Container(
                         width: 60.0,
                         height: 60.0,
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             image: DecorationImage(
                                 image: new NetworkImage(widget.user.photoUrl))),
                       ),
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text('Welcome',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white)),
                              new Text(
                                widget.user.displayName,
                                style: TextStyle(
                                    fontSize: 24.0, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      new IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: _signOut)
                    ],
                  ),
                ),
                new Text(
                  "My Task",
                  style: new TextStyle(
                      color: Colors.white, fontSize: 30.0, letterSpacing: 2.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
//
//  Widget photoUrl(AsyncSnapshot<FirebaseUser> user) {
//    return Container(
//      width: 60.0,
//      height: 60.0,
//      decoration: BoxDecoration(
//          shape: BoxShape.circle,
//          image:
//              DecorationImage(image: new NetworkImage(user.data.photoUrl))),
//    );
//  }



  Widget buildList(AsyncSnapshot<PlanModel> snapshot) {
    if(snapshot.hasData && snapshot.data.task.length > 0){
      return ListView.builder(
          itemCount: snapshot.data.task.length,
          itemBuilder: (BuildContext context, int i) {
            String title = snapshot.data.task[i].title.toString();
            String note = snapshot.data.task[i].note.toString();
            //String dueDate = snapshot.data.task[i].duedate.toString();
            var parsedDate = DateTime.parse(snapshot.data.task[i].duedate.toString());
            String dueDate = "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
            return snapshot.data.task[i].email.toLowerCase().contains(widget.user.email.toLowerCase())?
              new Padding(
                  padding: const EdgeInsets.only(left:16.0,top: 8.0,right: 16.0,bottom: 8.0),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Container(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(title, style: new TextStyle(fontSize: 20.0, letterSpacing: 1.0),),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.date_range, color: Colors.black,),
                            ),
                            Text(dueDate, style: new TextStyle(fontSize: 18.0),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right:16.0),
                              child: Icon(Icons.note, color: Colors.black,),
                            ),
                            new Expanded(child: Text(note, style: new TextStyle(fontSize: 18.0),)),
                          ],
                        ),
                      ],
                    )),
                  ),
                  new IconButton(icon: Icon(Icons.edit), onPressed: (){})
                ],
              )
            ): new Container();



          });
    }else{
      return new Text("No items");
    }

  }
}
