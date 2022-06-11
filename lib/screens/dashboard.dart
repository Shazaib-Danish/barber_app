import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:gromify/screens/all_barbers.dart';
import 'package:gromify/theme/extention.dart';
import 'package:gromify/widgets/searching_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../data manager/data_manager.dart';
import '../model/barber_model.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';
import '../theme/theme.dart';
import '../widgets/barber_tile.dart';
import '../widgets/draawer.dart';
import '../widgets/header.dart';
import 'details_screen.dart';
import 'notification_screen.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  late List<BarberModel> barberDataList;
  late List<BarberModel> topBarberList;
  final _advancedDrawerController = AdvancedDrawerController();

  bool searchingStart = false;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<DataManagerProvider>(context, listen: false).setAllBarbers(barberDataList);
    });

    super.initState();

    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        Provider.of<DataManagerProvider>(context, listen: false)
            .searchList
            .clear();
        Provider.of<DataManagerProvider>(context, listen: false).setIsSearching(true);
          Provider.of<DataManagerProvider>(context, listen: false)
              .getSearch(textController.text);
      } else {
        Provider.of<DataManagerProvider>(context, listen: false).setIsSearching(false);
      }
    });
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search...",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
            width: 50,
            child:
                Icon(Icons.search, color: LightColor.purple).alignCenter.ripple(
                      () {},
                      borderRadius: BorderRadius.circular(13),
                    ),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Top Barbers", style: TextStyles.title.bold),
              Text(
                "See All",
                style: TextStyles.titleNormal
                    .copyWith(color: Theme.of(context).primaryColor),
              ).p(8).ripple(() {})
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: topBarberList.map((x) {
                return _categoryCardWidget(
                  x,
                  color: LightColor.orange,
                  lightColor: LightColor.lightOrange,
                );
              }).toList()),
        ),
      ],
    );
  }

  Widget _categoryCardWidget(
    BarberModel barberModel, {
    required Color color,
    required Color lightColor,
  }) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .4,
        margin: const EdgeInsets.only(left: 10, right: 15, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(1.0, 1.0),
              blurRadius: 10.0,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(barberModel.image), fit: BoxFit.cover),
            ),
            child: Container(
              color: Colors.black38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(barberModel.shopName, style: titleStyle).hP8,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SmoothStarRating(
                      onRatingChanged: (v) {},
                      starCount: 5,
                      rating: barberModel.rating,
                      size: 20.0,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                      spacing: 0.0),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${num.parse('${barberModel.goodReviews}')} Reviews',
                      style: subtitleStyle,
                    ).hP8,
                  ),
                ],
              ).p16,
            ),
          ),
        ).ripple(() {
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ).ripple(
        () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => DetailScreen(model: barberModel)));
        },
      ),
    );
  }

  Widget _barbersList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("All Barbers", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const AllBarbers()));
                  })
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          getbarberWidgetList()
        ],
      ),
    );
  }

  Widget getbarberWidgetList() {
    return Column(
        children: barberDataList.map((x) {
      return barberTile(x, context);
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
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
            ClipRRect(
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
          ],
        ),
        backgroundColor: Colors.white,
        body: CustomScrollView(
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
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: InputBorder.none,
                        hintText: "Search...",
                        hintStyle: TextStyles.body.subTitleColor,
                        suffixIcon: SizedBox(
                          width: 50,
                          child: Icon(Icons.search, color: LightColor.purple)
                              .alignCenter
                              .ripple(
                                () {},
                                borderRadius: BorderRadius.circular(13),
                              ),
                        ),
                      ),
                    ),
                  ),
                   Provider.of<DataManagerProvider>(context).searchingStart ? Text('') :_category(),
                ],
              ),
            ),
            Provider.of<DataManagerProvider>(context).searchingStart ? const SearchingScreen() :_barbersList(),
          ],
        ),
      ),
    );
  }
}
