import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:todo_app/bloc/todo_cubit.dart';
import 'package:todo_app/utils/alert_dialog.dart';
import 'package:todo_app/utils/date_converter.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var textFieldController = TextEditingController();

   @override
  void initState() {
     context.read<TodoCubit>().initializeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('To Do App'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
          if(state.isLoading && state.todoList.isNotEmpty){
            return Center(child: LoadingAnimationWidget.threeArchedCircle(color: Colors.blue, size: 100),);
          } else if(!state.isLoading && state.todoList.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/box-shake.gif',height: 200, width: 200,),
                  const Text('To Do is Empty!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 5),
            shrinkWrap: false,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: state.todoList.length,itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(onPressed: (value) {
                    genericDialog(context, title: 'Edit Task', widget: TextField(controller: textFieldController), buttonText: 'Save',function: () {
                      context.read<TodoCubit>().editTodo(context, state.todoList[index].todo!, textFieldController.text);
                    }).then((value) => textFieldController.clear());
                  }, backgroundColor: Colors.green, icon: Icons.edit,),
                   SlidableAction(onPressed: (value) {
                    context.read<TodoCubit>().deleteTodo(context, index);
                  }, backgroundColor: Colors.red, icon: Icons.delete,),
                ],
              ),
                child: ListTile(leading: const Icon(Icons.task),
                        title: Text(state.todoList[index].todo!),
                        trailing: Text(dateTimeFormat(state.todoList[index].date!)),
                        tileColor: Colors.grey[200],
                      ),
            );
          },);
          // return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 50,),);

        },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          genericDialog(context, title: 'Enter Task', widget: TextField(controller: textFieldController), buttonText: 'Add',
              function: (){
                context.read<TodoCubit>().addTodo(context, textFieldController);
              }).then((value) => textFieldController.clear());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
