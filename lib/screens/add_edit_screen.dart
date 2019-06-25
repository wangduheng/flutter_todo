import 'package:flutter/material.dart';
import 'package:flutter_todos/pojo/todo.dart';
import 'package:todos_app_core/todos_app_core.dart';

typedef OnSaveCallBack = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Todo todo;
  final OnSaveCallBack onSave;

  AddEditScreen({
    Key key,
    @required this.isEditing,
    @required this.onSave,
    this.todo,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  State<StatefulWidget> createState() {
    return _AddEditScreenState();
  }
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editTodo : localizations.addTodo,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: isEditing ? widget.todo.task : '',
                  key: ArchSampleKeys.taskField,
                  autofocus: !isEditing,
                  style: textTheme.headline,
                  validator: (value) {
                    return value.trim().isEmpty
                        ? localizations.emptyTodoError
                        : null;
                  },
                  onSaved: (value) => _task = value,
                  decoration:
                      InputDecoration(hintText: localizations.newTodoHint),
                ),
                TextFormField(
                  initialValue: isEditing ? widget.todo.note : '',
                  key: ArchSampleKeys.noteField,
                  style: textTheme.subhead,
                  maxLines: 10,
                  onSaved: (value) => _note = value,
                  decoration:
                      InputDecoration(hintText: localizations.notesHint),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }

        },
        child: Icon(isEditing ? Icons.check : Icons.add),
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
      ),
    );
  }
}
