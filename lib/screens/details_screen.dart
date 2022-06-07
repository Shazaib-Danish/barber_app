import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/theme/extention.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/barber_model.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';
import '../theme/theme.dart';
import '../widgets/progress_widgets.dart';

/*
Title:DetailScreen
Purpose:DetailScreen
Created By:Kalpesh Khandla
Created Date: 30 April 2021
*/

class DetailScreen extends StatefulWidget {
  final BarberModel model;
  DetailScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailScreen> {
  late BarberModel model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _smsLauncher(String phoneNumber) async{
    // Android
    String message = '';
    String uri = 'sms:$phoneNumber?body=$message';
    if (await canLaunch(uri)) {
    await launch(uri);
    } else {
    throw 'Could not launch';
    }
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const BackButton(
          color: Colors.white,
        ),
        IconButton(
          icon: Icon(
            model.isfavourite ? Icons.favorite : Icons.favorite_border,
            color: model.isfavourite ? Colors.deepOrange : Colors.white,
          ),
          onPressed: () {
            setState(() {
              model.isfavourite = !model.isfavourite;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'image',
              transitionOnUserGestures: true,
              child: Container(
                  color: Colors.blueAccent,
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Image.asset(model.image, fit: BoxFit.fitHeight,)),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.shopName,
                                style: titleStyle.copyWith(
                                  color: Colors.black
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SmoothStarRating(
                                    onRatingChanged: (v) {},
                                    starCount: 5,
                                    rating: model.rating,
                                    size: 20.0,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star,
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                    spacing:0.0
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                model.barberName,
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                              Spacer(),
                              Text(model.seats, style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900
                              ),),
                              const Icon(Icons.event_seat,color: Colors.deepOrangeAccent,)
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.blueAccent,size: 18,),
                            Text(model.address,style: TextStyle(color: Colors.grey[600]),),
                          ],
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                              value: model.goodReviews,
                              totalValue: 1000,
                              activeColor: LightColor.purpleExtraLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Good Reviews",
                              durationTime: 500,
                            ),
                            ProgressWidget(
                              value: model.totalScore,
                              totalValue: 100,
                              activeColor: LightColor.purpleLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Total Score",
                              durationTime: 300,
                            ),
                            ProgressWidget(
                              value: model.satisfaction,
                              totalValue: 100,
                              activeColor: LightColor.purple,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Satisfaction",
                              durationTime: 800,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        Text(
                          model.description,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                                  () {
                                    _launchCaller(model.barberContact);
                                  },
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                                  () {
                                    _smsLauncher(model.barberContact);
                                  },
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Make an appointment",
                                  style: TextStyles.titleNormal.white,
                                ),
                              ),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
