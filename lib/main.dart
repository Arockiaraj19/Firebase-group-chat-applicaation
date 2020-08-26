import 'package:chat_app/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import './screen/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat app',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor:Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        ),
     
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx,userSnapshot){
        if(userSnapshot.hasData){
          return ChatScreen();//if token generated a stream has a data , a token is there so we go to the chatscreen else authscreen
        }
        return AuthScreen();

      },),
      
    );
  }
}
