import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget whereToButton(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.search,),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text('Where to?', style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),)
          ],
        ),
      ),
    ),
  );
}