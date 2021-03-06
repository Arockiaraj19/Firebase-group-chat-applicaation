import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/message_view.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
                return ListView.builder(
                reverse: true,
                itemCount: chatSnapshot.data.documents.length,
                itemBuilder: (ctx, index) => MessageView(
                  chatSnapshot.data.documents[index]['text'],
                  chatSnapshot.data.documents[index]['username'],
                  chatSnapshot.data.documents[index]['userImage'],
                  chatSnapshot.data.documents[index]['userId']==futureSnapshot.data.uid,
                  key: ValueKey(chatSnapshot.data.documents[index].documentID),//a key is used for effeciently update the data
                ),
                
              );
            });
      },
    );
  }
}
