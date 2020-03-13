import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:tinder/src/data/model/user_data.dart';
import 'package:tinder/src/feature/media/media_presenter.dart';
import 'package:tinder/src/feature/widget/personal_details.dart';
import 'package:tinder/src/utils/hex_color.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> implements MediaPageContract {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  BuildContext _context;
  MediaPagePresenter _presenter;
  User people;
  bool _isViewDetails = false;
  bool _isNetworkConnected = true;
  int _selectedIndex = 0;

  _MediaPageState() {
    _presenter = new MediaPagePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isNetworkConnected = true;
    _isViewDetails = false;
    _selectedIndex = 0;
    _presenter.nextPeople();
  }

  Widget NoNetworkConnected = Center(
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Center(
        child: Text(
          "Lỗi kết nối mạng, vui lòng mở kết nối mạng hoặc thử mở lại trang",
          textScaleFactor: 2.0,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _context = context;
    final screenSize = MediaQuery.of(context).size;

    final loadImage = people != null
        ? new CachedNetworkImage(
            imageUrl: people.picture,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : NoNetworkConnected;

    Widget cardControl = Card(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment(0.0, -0.8),
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 130,
                      decoration: BoxDecoration(
                        color: HexColor("#f9f9f9"),
                        border: Border(
                            bottom: BorderSide(
                                color: HexColor("#e2e2e2"), width: 1)),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 60),
                        child: DefaultTabController(
                          length: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints.expand(height: 100),
                                child: TabBarView(
                                  children: <Widget>[
                                    TabInfo(
                                        "My name is",
                                        people != null
                                            ? "${people.name.title} ${people.name.first} ${people.name.last}"
                                            : ""),
                                    TabInfo("My SSN is",
                                        people != null ? people.SSN : ""),
                                    TabInfo(
                                        "My address is",
                                        people != null
                                            ? "${people.location.street} - ${people.location.city} - ${people.location.state}"
                                            : ""),
                                    TabInfo(
                                        "My phone is",
                                        people != null
                                            ? "${people.phone} - or ${people.cell}"
                                            : ""),
                                    TabInfo("My password is",
                                        people != null ? people.password : ""),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints.expand(height: 50),
                                padding: EdgeInsets.only(left: 60, right: 60),
                                child: TabBar(
                                    indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 3.0),
                                      insets: EdgeInsets.fromLTRB(
                                          40.0, 0.0, 40.0, 40.0),
                                    ),
                                    onTap: (index) {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                    tabs: [
                                      Tab(
                                        icon: Icon(
                                          Icons.person_pin,
                                          color: _selectedIndex == 0
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      Tab(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: _selectedIndex == 1
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      Tab(
                                        icon: Icon(
                                          Icons.map,
                                          color: _selectedIndex == 2
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      Tab(
                                        icon: Icon(
                                          Icons.phone,
                                          color: _selectedIndex == 3
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      Tab(
                                        icon: Icon(
                                          Icons.lock,
                                          color: _selectedIndex == 4
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                  child: people != null
                      ? new CircleAvatar(
                          foregroundColor: Colors.white,
                          radius: 30.0,
                          backgroundImage: NetworkImage(people.picture),
                          backgroundColor: Colors.transparent)
                      : Text(""),
                  width: 150.0,
                  height: 150.0,
                  padding: const EdgeInsets.all(3.0), // borde width
                  decoration: new BoxDecoration(
                      color: Colors.white, // border color
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.grey))),
            ],
          ),
        ],
      ),
    );

    Widget sizeBoxControl = Container(
      decoration: BoxDecoration(color: HexColor("#f9f9f9")),
      child: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: HexColor("#2d2e32"),
                  ),
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 10, top: 20),
                  child: cardControl,
                )
              ],
            ),
          ],
        ),
      ),
    );

    Widget resultView;
    if (!_isNetworkConnected) {
      resultView = Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Tinder"),
          centerTitle: true,
          backgroundColor: HexColor("#FE3C72"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite), onPressed: showFavoritePeople),
          ],
        ),
        body: NoNetworkConnected,
      );
    } else {
      resultView = Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Tinder"),
          centerTitle: true,
          backgroundColor: HexColor("#FE3C72"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite), onPressed: showFavoritePeople),
          ],
        ),
        body: Center(
          child: Container(
            child: SwipeDetector(
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: screenSize.width,
                        height: screenSize.height,
                        child: loadImage),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: _isViewDetails
                          ? sizeBoxControl
                          : PreferredSize(
                              child: Container(),
                              preferredSize: Size(0.0, 0.0),
                            ),
                    )
                  ],
                ),
                onSwipeUp: () {
                  viewDetails();
                },
                onSwipeDown: () {
                  setState(() {
                    _isViewDetails = false;
                  });
                },
                onSwipeLeft: () {
                  setState(() {
                    _isNetworkConnected = true;
                  });
                  _presenter.nextPeople();
                },
                onSwipeRight: () {
                  setState(() {
                    _isNetworkConnected = true;
                  });
                  _presenter.addFavorite(people);
                }),
          ),
        ),
      );
    }
    return resultView;
  }

  void getPeople() {}

  void viewDetails() {
    setState(() {
      _isViewDetails = true;
    });
  }

  @override
  void showFavoritePeople() {
    Navigator.of(_context).pushNamed("/favorite");
  }

  @override
  void showPeople(User user) {
    setState(() {
      _isNetworkConnected = true;
      people = user;
    });
  }

  @override
  void showError(String error) {
    setState(() {
      _isNetworkConnected = false;
    });
  }
}
