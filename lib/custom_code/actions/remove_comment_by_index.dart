// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<dynamic>> removeCommentByIndex(
  List<dynamic> jsonData, // $.structure
  int structureIndex,
  int questionIndex,
  int commentIndex,
) async {
  bool removed = false;

  try {
    // Проверяем существование раздела
    if (structureIndex >= 0 && structureIndex < jsonData.length) {
      var structure = jsonData[structureIndex];

      if (structure.containsKey('questions')) {
        var questions = structure['questions'];

        // Проверяем существование вопроса
        if (questionIndex >= 0 && questionIndex < questions.length) {
          var question = questions[questionIndex];

          if (question.containsKey('comments') &&
              question['comments'] != null) {
            var comments = question['comments'];

            // Проверяем индекс комментария
            if (commentIndex >= 0 && commentIndex < comments.length) {
              var removedComment = comments.removeAt(commentIndex);
              print('✅ Комментарий "$removedComment" успешно удалён.');
              removed = true;
            } else {
              print('❌ Неверный индекс commentIndex: $commentIndex');
            }
          } else {
            print('⚠️ У вопроса нет поля comments');
          }
        } else {
          print('❌ Неверный индекс questionIndex: $questionIndex');
        }
      } else {
        print('⚠️ У structure нет поля questions');
      }
    } else {
      print('❌ Неверный индекс structureIndex: $structureIndex');
    }

    if (!removed) {
      print('🚫 Комментарий не был удалён.');
    }
  } catch (e) {
    print('⚠️ Ошибка при удалении комментария: $e');
  }

  // Возвращаем обновлённый jsonList
  return jsonData;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
