import 'package:flutter/material.dart';
import 'package:sayit/config/Palette.dart';

import 'package:sayit/pages/ConversationBottomSheet.dart';
import '../widgets/ChatAppBar.dart';
import '../widgets/ChatListWidget.dart';
import '../widgets/InputWidget.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() {
    return _ConversationPageState();
  }

  const ConversationPage();
}

class _ConversationPageState extends State<ConversationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ChatAppBar(),
        ),
        Expanded(
          flex: 11,
          child: Container(
            color: Palette.chatBackgroundColor,
            child: ChatListWidget(),
          ),
        )
      ],
    );
  }
}
