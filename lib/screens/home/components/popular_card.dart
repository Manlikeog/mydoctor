import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularCard extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  const PopularCard(
      {Key? key, required this.image, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: Colors.white),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: image != null
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        height: 188,
                        width: 198,
                      )
                    : Image.asset('assets/images/blurblue.png')),
            const SizedBox(
              height: 10,
            ),
            Text(
              text1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text2,
              style: const TextStyle(
                color: Color(0xa1677294),
                fontSize: 13,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: const Color(0xffF6D060),
                  size: 15,
                ),
                Icon(
                  Icons.star,
                  color: const Color(0xffF6D060),
                  size: 15,
                ),
                Icon(
                  Icons.star,
                  color: const Color(0xffF6D060),
                  size: 15,
                ),
                Icon(
                  Icons.star,
                  color: const Color(0xffF6D060),
                  size: 15,
                ),
                Icon(
                  Icons.star,
                  color: const Color(0xffE2E5EA),
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
