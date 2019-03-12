import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/task_model.dart';

class TaskBloc{
final _repository = Repository();
final _taskFetcher = PublishSubject<PlanModel>();
// final _title = BehaviorSubject<String>();
// final _date = BehaviorSubject<String>();
// final _note = BehaviorSubject<String>();
// final _level = BehaviorSubject<String>();
// final _email = BehaviorSubject<String>();

Observable<PlanModel> get allPlans => _taskFetcher.stream;
// Function(String) get updateTitle => _title.sink.add;
// Function(String) get updateDate => _date.sink.add;
// Function(String) get updateNote => _note.sink.add;
// Function(String) get updateEmail => _email.sink.add;
// Function(String) get updateLevel => _level.sink.add;

fetchAllPlans() async{
  PlanModel planModel = await _repository.fetchAllPlans();
  _taskFetcher.sink.add(planModel);
}

addSaveTask(String _title,String _date, String _note,String _level, String _email){
  print(_title);
  print(_date);
  print(_note);
  print(_level);
  print(_email);
  _repository.addSaveTask(_title,_date,_note,_level,_email);
}
dispose(){
  _taskFetcher.close();
}
}
final bloc = TaskBloc();