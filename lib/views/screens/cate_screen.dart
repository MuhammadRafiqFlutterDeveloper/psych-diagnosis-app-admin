import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';

import 'layouts_bubble.dart';

final firestoreInstance = FirebaseFirestore.instance;

class ProviderChatScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String image;
  final String email;
  final String reply;
  final String issueTitle;

  ProviderChatScreen(
      {required this.userId,
      required this.name,
      required this.email,
      required this.image,
      required this.reply,
      required this.issueTitle});

  @override
  _ProviderChatScreenState createState() => _ProviderChatScreenState();
}

class _ProviderChatScreenState extends State<ProviderChatScreen>
    with WidgetsBindingObserver {
  final _firestore = FirebaseFirestore.instance;
  final _textController = TextEditingController();
  bool _isOnline = false;
  StreamSubscription<DocumentSnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateUserStatus(true);
    _listenForUserStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateUserStatus(false);
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _updateUserStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _updateUserStatus(false);
        break;
    }
  }

  void _updateUserStatus(bool isOnline) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firestoreInstance.collection('users').doc(user.uid).update(
          {'isOnline': isOnline, 'lastSeen': FieldValue.serverTimestamp()});
    }
  }

  void _listenForUserStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _subscription = firestoreInstance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((snapshot) {
        final isOnline = snapshot.data()?['isOnline'] ?? false;
        setState(() {
          _isOnline = isOnline;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        title: ListTile(
          contentPadding: EdgeInsets.only(left: 0),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.image),
            radius: 20,
          ),
          title: Text(widget.name),
          subtitle: Text(
            _isOnline ? 'Online' : 'Offline',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xff808080)),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Text(
                  'Issue Title',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: buttonColor),
                ),
                subtitle: Text(
                  widget.issueTitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Image.asset(
                  'assets/logo/img_8.png',
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                );
              }

              final messages = snapshot.data!.docs
                  .where((doc) =>
                      (doc.get('sender') ==
                              FirebaseAuth.instance.currentUser!.uid &&
                          doc.get('recipient') == widget.userId) ||
                      (doc.get('sender') == widget.userId &&
                          doc.get('recipient') ==
                              FirebaseAuth.instance.currentUser!.uid))
                  .toList();

              messages.sort(
                  (a, b) => a.get('timestamp').compareTo(b.get('timestamp')));

              List<MessageBubble> messageBubbles = [];
              for (var message in messages) {
                final messageText = message.get('text');
                final messageSender = message.get('sender');
                final messageTimestamp = message.get('timestamp');
                final isSent =
                    messageSender == FirebaseAuth.instance.currentUser!.uid;
                final messageBubble = MessageBubble(
                  reply: widget.reply,
                  text: messageText,
                  time: messageTimestamp.toDate(),
                  isSent: isSent,
                );
                messageBubbles.add(messageBubble);
              }

              return Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    reverse: false,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    onPressed: () async {
                      var _auth = await FirebaseAuth.instance;
                      _firestore.collection('messages').add({
                        'sender': FirebaseAuth.instance.currentUser!.uid,
                        'recipient': widget.userId,
                        'text': _textController.text,
                        'timestamp': Timestamp.now(),
                      }).whenComplete(
                        () {
                          final User? user = _auth.currentUser;
                          final userid = user!.uid;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userid)
                              .update(
                            {
                              'help': 'help',
                            },
                          );
                          print('FeedBack Successfully Sent');
                        },
                      );
                      _textController.clear();
                    },
                    child: Text(
                      'Send',
                      style: buttonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var kMessageContainerDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      blurRadius: 3,
      spreadRadius: 1,
      color: Colors.grey,
    ),
  ],
  border: Border(
    top: BorderSide(color: Colors.grey, width: 2.0),
  ),
);

var kMessageTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xffE1DFDF),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Write your message here....',
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(25),
  ),
);

var kSendButtonTextStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
