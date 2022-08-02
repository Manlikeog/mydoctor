import 'package:flutter/material.dart';

class PopularCategory extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String ratings;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final Color color5;
  const PopularCategory({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.ratings,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      child: Card(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    image,
                    height: 80,
                    width: 85,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0XFF677294),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: color1,
                            size: 17,
                          ),
                          Icon(
                            Icons.star,
                            color: color2,
                            size: 17,
                          ),
                          Icon(
                            Icons.star,
                            color: color3,
                            size: 17,
                          ),
                          Icon(
                            Icons.star,
                            color: color4,
                            size: 17,
                          ),
                          Icon(
                            Icons.star,
                            color: color5,
                            size: 17,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$ratings votes",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
