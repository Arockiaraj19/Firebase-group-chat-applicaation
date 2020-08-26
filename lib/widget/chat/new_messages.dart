import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller=new TextEditingController();
  var _enteredMessage='';



  void _sentMessage() async {
    FocusScope.of(context).unfocus();
   
    final user=await FirebaseAuth.instance.currentUser();
    final userData=await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text':_enteredMessage,
      'createdAt':Timestamp.now(),
      'userId':user.uid,
      'username':userData['username'],
      'userImage':userData['url'],
    });
   _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller:_controller ,
              decoration: InputDecoration(
                labelText:'send a message..'
              ),
              onChanged: (value){
                setState(() {
                  _enteredMessage=value;
                });
            },
            ),  
          ),
           IconButton(color: Theme.of(context).primaryColor,icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ?null :_sentMessage,),
        ],
      ),
    );
  }
}
