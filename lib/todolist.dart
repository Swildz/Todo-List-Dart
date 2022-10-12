// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:convert';

class Todolist {
  String dataName = '';

  Todolist([String dataName = 'data.json']) {
    // ignore: prefer_initializing_formals
    this.dataName = dataName;
    bool fileExist = File(this.dataName).existsSync() &&
        FileSystemEntity.isFileSync(this.dataName);
    if (!fileExist) {
      File(this.dataName).createSync();
      File(this.dataName).writeAsStringSync('[]');
    }
  }

  List<dynamic> getAll() {
    String contentFile = File(dataName).readAsStringSync().trim();
    List<dynamic> object = jsonDecode(contentFile);
    return object;
  }

  Map? getByNoUrut(int noUrut) {
    int no = noUrut - 1;
    Map? result;
    List<dynamic> todos = getAll();
    if (todos.asMap().containsKey(no)) {
      result = todos[no];
    }
    return result;
  }

  bool add(
      {required int nrp,
      required String name,
      required String todo,
      // ignore: non_constant_identifier_names
      bool is_active = true,
      // ignore: non_constant_identifier_names
      bool is_done = false}) {
    bool result = false;

    Map newTodo = {
      'nrp': nrp,
      'name': name,
      'todo': todo,
      'is_active': is_active,
      'is_done': is_done,
    };

    List<dynamic> allTodo = getAll();
    int todoLength = allTodo.length;

    allTodo.insert(todoLength, newTodo);
    if (allTodo.asMap().containsKey(todoLength)) {
      File(dataName).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }
    return result;
  }

  bool edit(int noUrut,
      {int? nrp, String? name, String? todo, bool? is_active, bool? is_done}) {
    bool result = false;
    int no = noUrut - 1;
    List<dynamic> allTodo = getAll();

    if (allTodo.asMap().containsKey(no)) {
      Map todoData = allTodo[no];
      todoData['nrp'] = nrp ?? todoData['nrp'];
      todoData['name'] = name ?? todoData['name'];
      todoData['todo'] = todo ?? todoData['todo'];
      todoData['is_active'] = is_active ?? todoData['is_active'];
      todoData['is_done'] = is_done ?? todoData['is_done'];

      allTodo[no] = todoData;

      File(dataName).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }

    return result;
  }

  bool deleteByNoUrut(int noUrut) {
    bool result = false;
    int no = noUrut - 1;
    List<dynamic> allTodo = getAll();
    if (allTodo.asMap().containsKey(no)) {
      allTodo.removeAt(no);
      File(dataName).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }

    return result;
  }
}
