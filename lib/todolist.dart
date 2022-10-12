// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:convert';

class Todolist {
  String filename = '';

  Todolist([String filename = 'data.json']) {
    // ignore: prefer_initializing_formals
    this.filename = filename;
    bool fileExist = File(this.filename).existsSync() &&
        FileSystemEntity.isFileSync(this.filename);
    if (!fileExist) {
      File(this.filename).createSync();
      File(this.filename).writeAsStringSync('[]');
    }
  }

  List<dynamic> getAll() {
    String contentFile = File(filename).readAsStringSync().trim();
    List<dynamic> object = jsonDecode(contentFile);
    return object;
  }

  Map? getByNoUrut(int noUrut) {
    int indek = noUrut - 1;
    Map? result;
    List<dynamic> todos = getAll();
    if (todos.asMap().containsKey(indek)) {
      result = todos[indek];
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
      File(filename).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }
    return result;
  }

  bool edit(int noUrut,
      {int? nrp, String? name, String? todo, bool? is_active, bool? is_done}) {
    bool result = false;
    int indek = noUrut - 1;
    List<dynamic> allTodo = getAll();

    if (allTodo.asMap().containsKey(indek)) {
      Map todoData = allTodo[indek];
      todoData['nrp'] = nrp ?? todoData['nrp'];
      todoData['name'] = name ?? todoData['name'];
      todoData['todo'] = todo ?? todoData['todo'];
      todoData['is_active'] = is_active ?? todoData['is_active'];
      todoData['is_done'] = is_done ?? todoData['is_done'];

      allTodo[indek] = todoData;

      File(filename).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }

    return result;
  }

  bool deleteByNoUrut(int noUrut) {
    bool result = false;
    int indek = noUrut - 1;
    List<dynamic> allTodo = getAll();
    if (allTodo.asMap().containsKey(indek)) {
      allTodo.removeAt(indek);
      File(filename).writeAsStringSync(jsonEncode(allTodo));
      result = true;
    }

    return result;
  }
}
