

class MessageModel {

  int id;
  String body;
  String is_send;
  String is_receive;
  int user_id;
  int conversation_id;
  String created_at;
  String updated_at;
  bool is_play;
  String is_audio;

  MessageModel({
    this.id,
    this.body,
    this.is_send,
    this.is_receive,
    this.user_id,
    this.conversation_id,
    this.created_at,
    this.updated_at,
    this.is_play,
    this.is_audio
  });




}