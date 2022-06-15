import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:gromify/firebase_data/firebase_data.dart';
import 'package:gromify/screens/profile_screen.dart';
import 'package:gromify/theme/extention.dart';
import 'package:gromify/widgets/searching_screen.dart';
import 'package:provider/provider.dart';

import '../data manager/data_manager.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';
import '../widgets/dashboard/barber_list_widget.dart';
import '../widgets/dashboard/category.dart';
import '../widgets/draawer.dart';
import '../widgets/header.dart';
import 'notification_screen.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  bool searchingStart = false;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        Provider.of<DataManagerProvider>(context, listen: false)
            .searchList
            .clear();
        Provider.of<DataManagerProvider>(context, listen: false)
            .setIsSearching(true);
        Provider.of<DataManagerProvider>(context, listen: false)
            .getSearch(textController.text);
      } else {
        Provider.of<DataManagerProvider>(context, listen: false)
            .setIsSearching(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllBarbers(context);
    getTopBarbers(context);
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: false,
      //openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const Draawer(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              _advancedDrawerController.showDrawer();
            },
            child: const Icon(
              Icons.short_text,
              size: 30,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: const Icon(
                Icons.notifications_none,
                size: 30,
                color: LightColor.grey,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => UserProfileScreen()));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: Container(
                  // height: 40,
                  // width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Image.asset("assets/user.jpg", fit: BoxFit.fill),
                ),
              ).p(8),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Consumer<DataManagerProvider>(
          builder: (context, providerData, child) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const Header(),
                      Container(
                        height: 55,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: LightColor.grey.withOpacity(.8),
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        child: TextField(
                          controller: textController,
                          onChanged: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            border: InputBorder.none,
                            hintText: "Search...",
                            hintStyle: TextStyles.body.subTitleColor,
                            suffixIcon: SizedBox(
                              width: 50,
                              child:
                                  Icon(Icons.search, color: LightColor.purple)
                                      .alignCenter
                                      .ripple(
                                        () {},
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Provider.of<DataManagerProvider>(context).searchingStart
                          ? Text('')
                          : category(providerData.getTopBarbers, context),
                    ],
                  ),
                ),
                Provider.of<DataManagerProvider>(context).searchingStart
                    ? const SearchingScreen()
                    : barbersList(providerData.getAllBarbers, context),
              ],
            );
          },
        ),
      ),
    );
  }
}
