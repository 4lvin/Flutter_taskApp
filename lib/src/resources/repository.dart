import '../resources/task_api_provider.dart';
import '../models/task_model.dart';

class Repository{
  final taskApiProvider = TaskApiProvider();

  Future<PlanModel> fetchAllPlans() => taskApiProvider.fetchTaskList();
  Future addSaveTask(String title,String date,String note, String level,String email) => 
  taskApiProvider.addTask(title,date,note,level,email);
}