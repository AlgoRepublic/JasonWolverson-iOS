import 'dart:convert';

import 'package:jasonw/models/MessageModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class ChatModel extends Model {
  List<MessageModel> messagesList = [];

  void updateToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId');
    print("userId= $userId");
    final Map<String, dynamic> data = {
      'user_id': userId.toString(),
      'fcm_token': token,
    };
    var jsonResponse;
    http.Response response = await http.post(
      "https://app.jasonwolverson.net/api/users/update_fcm_token",
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
    }
  }

  Future<void> getAllChat() async {
    print("gettAll list");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int userId = sharedPreferences.getInt('userId');
    var jsonResponse;
    print(userId);
    String url =
        'https://app.jasonwolverson.net/api/imessage/message_listing?sender_id=$userId';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("chat messages");
      print(jsonResponse);
      List<MessageModel> tempMessagesList = [];

      var _messages = jsonResponse["data"] as List;
      for (int i = 0; i < _messages.length; i++) {
        int id = _messages[i]['id'];
        String body = _messages[i]['body'].toString();
        String is_send = _messages[i]['is_send'].toString();
        String is_audio = _messages[i]['audio'].toString();
        String createdAt = _messages[i]['created_at'].toString();
        String is_receive = _messages[i]['is_receive'].toString();
        int user_id = _messages[i]['user_id'];
        int conversation_id = _messages[i]['conversation_id'];

        MessageModel msg = new MessageModel(
          id: id,
          body: body,
          is_send: is_send,
          is_receive: is_receive,
          user_id: user_id,
          conversation_id: conversation_id,
          is_play: false,
          created_at: createdAt,
          is_audio: is_audio,
        );
        tempMessagesList.add(msg);
      }
      messagesList = tempMessagesList.reversed.toList();
      notifyListeners();

//
// //      if (!mounted) return;
//       setState(() {
//         _Messages.addAll(listm.reversed);
//         _isLoading = false;
//        _scrollController.animateTo(0.0,
//            curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
      // });
    } else {
      // jsonResponse = json.decode(response.body);
      // var success = jsonResponse["success"];
      // print(jsonResponse);
      // print(success);
      // print(response.body);

      // if (!mounted) return;
      // setState(() {
      //   _isLoading = false;
      // });
      // showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }

  List<MessageModel> get getAllMessagesInChat {
    return messagesList;
  }
}
