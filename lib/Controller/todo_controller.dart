import 'package:flutterapi/Models/todo.dart';
import 'package:flutterapi/Repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  //get
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  //patch
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }
}
