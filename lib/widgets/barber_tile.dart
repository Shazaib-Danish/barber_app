import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gromify/theme/extention.dart';
import 'package:gromify/widgets/random_color.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../model/barber_model.dart';
import '../screens/details_screen.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';

Widget barberTile(BarberModel model, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: <BoxShadow>[
        const BoxShadow(
          offset: Offset(4, 4),
          blurRadius: 10,
          color: Colors.black26,
        ),
        BoxShadow(
          offset: const Offset(-3, 0),
          blurRadius: 15,
          color: LightColor.grey.withOpacity(.1),
        )
      ],
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          child: Hero(
            tag: 'image',
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(context),
              ),
              child: Image.network(
                model.image,
                loadingBuilder: (context, child, loading) {
                  if (loading == null)
                    return child;
                  else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.cyan,),
                    );
                  }
                },
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        title: Text(model.shopName,
            style: TextStyles.title.bold
                .copyWith(color: Colors.black, fontSize: 16.0)),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.barber.barberFullName,
                  style: TextStyles.bodySm.subTitleColor.bold
                      .copyWith(fontSize: 12.0),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                SmoothStarRating(
                    onRatingChanged: (v) {},
                    starCount: 5,
                    rating: model.rating,
                    size: 15.0,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star,
                    color: Colors.yellow[700],
                    borderColor: Colors.grey,
                    spacing: 0.0)
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(model.shopStatus.status, style: TextStyle(
                color: model.shopStatus.status == 'Open' ? Colors.green : Colors.red,
              ),),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ).ripple(
          () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => DetailScreen(model: model)));
      },
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
  );
}