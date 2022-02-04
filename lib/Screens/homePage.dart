import 'package:flutter/material.dart';
import 'package:flutterapi/Controller/todo_controller.dart';
import 'package:flutterapi/Models/todo.dart';
import 'package:flutterapi/Repository/todo_Repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //dependecy injection
    var todoController = TodoController(TodoRepository());
    //test
    // todoController.fetchTodoList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text("Rest API")),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          //
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo =
              Todo(userId: 4, title: 'Trial and error', completed: false);
          todoController.postTodo(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var todo = snapshot.data?[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 2, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () async {
                                todoController
                                    .updatePatchCompleted(todo!)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.black,
                                      duration:
                                          const Duration(milliseconds: 5000),
                                      content: Text(value),
                                    ),
                                  );
                                });
                              },
                              child: buildeCallContainer(
                                  'patch', Color(0xFFFFE0B2))),
                          InkWell(
                              onTap: () {
                                todoController.updatePutCompleted(todo!);
                              },
                              child: buildeCallContainer(
                                  'put', Color(0xFFE1BEE7))),
                          InkWell(
                              onTap: () {
                                todoController.deleteTodo(todo!).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.black,
                                      duration:
                                          const Duration(milliseconds: 5000),
                                      content: Text(value),
                                    ),
                                  );
                                });
                              },
                              child: buildeCallContainer(
                                  'del', Color(0xFFFFCDD2))),
                        ],
                      )),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildeCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          '$title',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
