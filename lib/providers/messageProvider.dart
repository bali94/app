import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/message.dart';
import 'package:juba/models/user.dart';
final messagesRef =
FirebaseFirestore.instance.collection('messages').withConverter<Message>(
  fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
  toFirestore: (msg, _) => msg.toJson(),
);
class MessageProvider extends ChangeNotifier {

  createMessage(Message message) {
    messagesRef.doc(message.messageId)
        .set(message);

  }
}