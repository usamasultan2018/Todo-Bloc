import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_bloc/cubit/todo_cubit.dart';
import 'package:todo_bloc/model/todo_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todCubit = BlocProvider.of<TodoCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "Add Task",
      ),
      body: BlocBuilder<TodoCubit,List<TodoModel>>(
        builder: (BuildContext context, state) {
          return ListView.builder(
            itemCount:state.length,
            itemBuilder: (context, index) {
              var data = state[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onLongPress: (){
                  todCubit.deleteTodo(index);
                },
                tileColor: Colors.red,
                title: Text(data.name,style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
                subtitle: Text(data.createdAt.toString(),style: TextStyle(
                  color: Colors.white,
                ),
                ),
              ),
            );
            },);
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final todoCubit = BlocProvider.of<TodoCubit>(context);
    TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Add Task",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Remind me gym at night",
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          return;
                        } else {
                          todoCubit.addTodoToList(controller.text);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
