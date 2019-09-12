import 'package:flutter/material.dart';
import 'package:sayit/config/Assets.dart';
import 'package:sayit/config/Palette.dart';
import 'package:sayit/config/Styles.dart';
import 'package:sayit/config/Transitions.dart';
import 'package:sayit/pages/ConversationPageSlide.dart';
import 'package:sayit/widgets/CircleIndicator.dart';
import 'package:sayit/widgets/NumberPicker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int currentPage = 0;
  int age = 18;
  var isKeyboardOpen = false;
  PageController pageController = PageController();
  Alignment begin = Alignment.center;
  Alignment end = Alignment.bottomRight;
  AnimationController usernameFieldAnimationController;
  Animation profilePicHeightAnimation, usernameAnimation, ageAnimation;
  FocusNode usernameFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    usernameFieldAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    profilePicHeightAnimation =
        Tween(begin: 100.0, end: 0.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    usernameAnimation =
        Tween(begin: 50.0, end: 10.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    ageAnimation =
        Tween(begin: 80.0, end: 10.0).animate(usernameFieldAnimationController)
          ..addListener(() {
            setState(() {});
          });
    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        usernameFieldAnimationController.forward();
      } else {
        usernameFieldAnimationController.reverse();
      }
    });
    pageController.addListener(() {
      setState(() {
        begin = Alignment(pageController.page, pageController.page);
        end = Alignment(1 - pageController.page, 1 - pageController.page);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: [Palette.gradientStartColor, Palette.gradientEndColor],
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int page) => updatePageState(page),
                    children: <Widget>[buildPageOne(), buildPageTwo()],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 2; i++)
                        CircleIndicator(i == currentPage),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: currentPage == 1 ? 1.0 : 0.0, //shows only on page 1
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () => navigateToHome(),
                          elevation: 0,
                          backgroundColor: Palette.primaryColor,
                          child: Icon(
                            Icons.done,
                            color: Palette.accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updatePageState(index) {
    if (index == 1)
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);

    setState(() {
      currentPage = index;
    });
  }

  Future<bool> onWillPop() {
    if (currentPage == 1) {
      //go to first page if currently on second page
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  buildPageOne() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Image.asset(Assets.app_icon_fg, height: 100),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Say It',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: ButtonTheme(
              height: 40,
              child: FlatButton.icon(
                onPressed: () => updatePageState(1),
                color: Colors.transparent,
                icon: Image.asset(
                  Assets.google_button,
                  height: 25,
                ),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(
                      color: Palette.primaryTextColorLight,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildPageTwo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            child: CircleAvatar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 15,
                  ),
                  Text(
                    'Set Profile Picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              backgroundImage: Image.asset(Assets.user).image,
              radius: 60,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'How old are you?',
            style: Styles.questionLight,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NumberPicker.horizontal(
                  initialValue: age,
                  minValue: 15,
                  maxValue: 100,
                  highlightSelectedValue: true,
                  onChanged: (num value) {
                    setState(() {
                      age = value;
                    });
                    //   print(age);
                  }),
              Text('Years', style: Styles.textLight)
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            child: Text(
              'Choose a username',
              style: Styles.questionLight,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 120,
            child: TextField(
              textAlign: TextAlign.center,
              style: Styles.subHeadingLight,
              decoration: InputDecoration(
                hintText: '@username',
                hintStyle: Styles.hintTextLight,
                contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.primaryColor, width: 0.1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.primaryColor, width: 0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    usernameFieldAnimationController.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final value = MediaQuery.of(context).viewInsets.bottom;
    if (value > 0) {
      if (isKeyboardOpen) {
        onKeyboardChanged(false);
      }
      isKeyboardOpen = false;
    } else {
      isKeyboardOpen = true;
      onKeyboardChanged(true);
    }
  }

  onKeyboardChanged(bool isVisible) {
    if (!isVisible) {
      FocusScope.of(context).requestFocus(FocusNode());
      usernameFieldAnimationController.reverse();
    }
  }

  navigateToHome() {
    Navigator.push(
      context,
      SlideLeftRoute(page: ConversationPageSlide()),
    );
  }
}
