import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/theme/extention.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../model/barber_model.dart';
import '../../screens/details_screen.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

Widget categoryCardWidget(
  BuildContext context,
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
      width: AppTheme.fullWidth(context) * .35,
      margin: const EdgeInsets.only(left: 10, right: 15, bottom: 20, top: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     offset: const Offset(1.0, 1.0),
        //     offset: const Offset(1.0, 1.0),
        //     blurRadius: 3.0,
        //     color: Colors.deepOrangeAccent,
        //   )
        // ],
      ),
      child: Material(
        elevation: 10.0,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(barberModel.image), fit: BoxFit.cover),
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
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
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
