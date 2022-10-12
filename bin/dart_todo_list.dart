import 'dart:io';

import 'package:dart_todo_list/todolist.dart';

void main(List<String> args) {
  Todolist todolist;
  todolist = Todolist();

  bool repeat = true;
  while (repeat) {
    print('Daftar Menu :');
    print('1. Daftar Todo Mahasiswa');
    print('2. Add Todo Mahasiswa');
    print('3. Edit Todo Mahasiswa');
    print('4. Delete Mahasiswa');
    print('5. Exit From Aplication');
    stdout.write('Silahkan Pilih Menu (1- 5): ');
    String? selected = stdin.readLineSync();
    switch (selected) {
      case '1':
        List<dynamic> all = todolist.getAll();

        print('Daftar Todo Mahasiswa :');
        String headerTable =
            '${'No'.padLeft(2, ' ')}. ${'NRP'.padRight(13, ' ')} ${'Nama'.padRight(13, ' ')} ${'Todo'.padRight(13, ' ')} ${'Aktif'.padRight(1, ' ')} Done';
        print(headerTable);
        print(''.padLeft(headerTable.length, '='));
        all.asMap().forEach((key, val) {
          // ignore: prefer_interpolation_to_compose_strings
          print(
              // ignore: prefer_interpolation_to_compose_strings
              '${'${(key + 1).toString().padLeft(1, ' ') + '. ' + val['nrp'].toString().padRight(15, ' ') + ' ' + val['name'].padRight(13, ' ')} ' + val['todo'].padRight(13, ' ')} ${(val['is_active'] == true ? 'y' : 'n').padRight(5, ' ')} ${val['is_done'] == true ? 'y' : 'n'}');
        });
        break;
      case '2':
        print('1. Add Todo Mahasiswa');
        int? nrp;
        String? name;
        String? todo;
        bool? isActive;
        bool? isDone;

        stdout.write('\t');
        do {
          stdout.write('nrp\t: ');
          String? tmpNrp = stdin.readLineSync();
          if (tmpNrp != null) {
            nrp = int.tryParse(tmpNrp);
          } else {
            stdoutWriteErr('\t[invalid input]');
          }
          ;
        } while (nrp == null);

        stdout.write('\t');
        do {
          stdout.write('nama\t: ');
          name = stdin.readLineSync();
        } while (name == null);
        stdout.write('\t');
        do {
          stdout.write('todo\t: ');
          todo = stdin.readLineSync();
        } while (todo == null);

        stdout.write('\t');
        do {
          stdout.write('isAktif (y/n)\t: ');
          String? tmpIsActive = stdin.readLineSync();
          if (tmpIsActive != null) {
            switch (tmpIsActive.trim().toLowerCase()) {
              case '':
              case 'y':
                isActive = true;
                break;
              case 'n':
                isActive = false;
                break;
              default:
                stdoutWriteErr('\t[invalid input]');
                break;
            }
          }
        } while (isActive == null);

        stdout.write('\t');
        do {
          stdout.write('isDone (y/n)\t: ');
          String? tmpIsDone = stdin.readLineSync();
          if (tmpIsDone != null) {
            switch (tmpIsDone.trim().toLowerCase()) {
              case 'y':
                isDone = true;
                break;
              case '':
              case 'n':
                isDone = false;
                break;
              default:
                stdoutWriteErr('\t[invalid input]');
                break;
            }
          }
        } while (isDone == null);

        bool isSuccess = todolist.add(
            nrp: nrp,
            name: name,
            todo: todo,
            is_active: isActive,
            is_done: isDone);
        isSuccess
            ? stdoutWriteSucc('[Add Success]\n')
            : stdoutWriteErr('[Add Failed]\n');
        break;
      case '3':
        int? noUrut;
        do {
          stdout.write('No Urut Todo\t: ');
          String? tmpNoUrut = stdin.readLineSync();
          if (tmpNoUrut != null &&
              int.tryParse(tmpNoUrut) != null &&
              todolist.getByNoUrut(int.parse(tmpNoUrut)) != null) {
            noUrut = int.parse(tmpNoUrut);
          } else {
            stdoutWriteErr('\t[invalid input] ');
          }
          ;
        } while (noUrut == null);

        print('2. Edit todo No Urut $noUrut');
        int? nrp;
        String? name;
        String? todo;
        bool? isActive;
        bool? isDone;

        stdout.write('\t');
        bool stopNrp = false;
        while (!stopNrp) {
          stdout.write('nrp\t: ');
          String? tmpNrp = stdin.readLineSync();
          if (tmpNrp != null) {
            if (tmpNrp.trim() != '' && int.tryParse(tmpNrp) != null) {
              nrp = int.parse(tmpNrp.trim());
            }

            stopNrp = true;
            continue;
          }

          stdoutWriteErr('\t[invalid input]');
        }

        stdout.write('\t');
        stdout.write('nama\t: ');
        name = stdin.readLineSync();
        if (name != null && name.trim() == '') {
          name = null;
        }
        stdout.write('\t');
        stdout.write('todo\t: ');
        todo = stdin.readLineSync();
        if (todo != null && todo.trim() == '') {
          todo = null;
        }

        stdout.write('\t');
        bool stopIsActive = false;
        while (!stopIsActive) {
          stdout.write('isAktif (y/n)\t: ');
          String? tmpIsActive = stdin.readLineSync();
          if (tmpIsActive != null) {
            switch (tmpIsActive.trim().toLowerCase()) {
              case '':
                break;
              case 'y':
                isActive = true;
                break;
              case 'n':
                isActive = false;
                break;
              default:
                stdoutWriteErr('\t[invalid input]');
                continue;
            }
          }

          stopIsActive = true;
        }

        stdout.write('\t');
        bool stopIsDone = false;
        while (!stopIsDone) {
          stdout.write('isDone (y/n)\t: ');
          String? tmpIsDone = stdin.readLineSync();
          if (tmpIsDone != null) {
            switch (tmpIsDone.trim().toLowerCase()) {
              case '':
                break;
              case 'y':
                isDone = true;
                break;
              case 'n':
                isDone = false;
                break;
              default:
                stdoutWriteErr('\t[invalid input]');
                continue;
            }
          }
          stopIsDone = true;
        }

        bool isSuccess = todolist.edit(noUrut,
            nrp: nrp,
            name: name,
            todo: todo,
            is_active: isActive,
            is_done: isDone);
        isSuccess
            ? stdoutWriteSucc('[Edit Success]\n')
            : stdoutWriteErr('[Edit Failed]\n');
        break;
      case '4':
        stdout.write('\t');
        int? noUrut;
        do {
          stdout.write(' no urut todo: ');
          String? tmpNoUrut = stdin.readLineSync();
          if (tmpNoUrut != null &&
              int.tryParse(tmpNoUrut) != null &&
              todolist.getByNoUrut(int.parse(tmpNoUrut)) != null) {
            noUrut = int.parse(tmpNoUrut);
          } else {
            stdoutWriteErr('\t[invalid input]');
          }
        } while (noUrut == null);

        bool isSuccess = todolist.deleteByNoUrut(noUrut);
        isSuccess
            ? stdoutWriteSucc('[Delete Success]\n')
            : stdoutWriteErr('[Delete Failed]\n');
        break;
      case '5':
        repeat = false;
        continue;
      default:
        stdoutWriteErr('[invalid input]\n');
        break;
    }
  }

  stdout.write('out from aplication...\n');
}

void stdoutWriteSucc(String text) {
  stdout.write('\x1B[32m$text\x1B[0m');
}

void stdoutWriteErr(String text) {
  stdout.write('\x1B[31m$text\x1B[0m');
}
