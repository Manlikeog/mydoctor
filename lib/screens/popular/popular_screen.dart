import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/doctors.dart';
import '../../widgets/background.dart';
import 'components/popular_category.dart';
import 'components/popular_screen_card.dart';

class PopularScreen extends StatelessWidget {
  static const routeName = "/popularScreen";

  const PopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<PopularDoctor>(context);
    final products = productData.popularItem;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: IconButton(
                        onPressed: (() => Navigator.pop(context)),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (() => Navigator.pop(context)),
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 25,
                      color: Color(0xff677294),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: const [
                    Text(
                      "Popular Doctor",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                    ),
                    Text(
                      "See all >",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff677294),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: 130,
            bottom: 480,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: products[i],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: PopularScreenCard(),
                    ),
                  );
                },
              ),
            ),
          ),
          const Positioned.fill(
            top: 420,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Ratings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 420,
            child: ListView.builder(
              itemCount: products.length,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, i) {
                return ChangeNotifierProvider.value(
                  value: products[i],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: PopularCategory(
                      image: products[i].image,
                      title: products[i].text1,
                      description: products[i].text2,
                      ratings: products[i].ratings,
                      color1: products[i].color1,
                      color2: products[i].color2,
                      color3: products[i].color3,
                      color4: products[i].color4,
                      color5: products[i].color5,
                    ),
                  ),
                );
              },
              itemExtent: 120,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
