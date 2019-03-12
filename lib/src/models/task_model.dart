class PlanModel {

  List<_Result> _result= [];

PlanModel.fromJson(Map<String,dynamic> parsedJson){
  print(parsedJson['tasks'].length);
  List<_Result> temp = [];
  for(int i =0; i < parsedJson['tasks'].length; i++){
    _Result result = _Result(parsedJson['tasks'][i]);
    temp.add(result);
  }
  _result = temp;
}
List<_Result> get task => _result;

}

class _Result{

  String _duedate;
  String _email;
  String _note;
  String _title;
  String _level;

  _Result(result){
    _duedate = result['duedate'];
    _email = result['email'];
    _note = result['note'];
    _title = result['title'];
    _level = result['level'];
  }
  String get duedate => _duedate;
  String get email => _email;
  String get note => _note;
  String get title => _title;
  String get level => _level;
}
