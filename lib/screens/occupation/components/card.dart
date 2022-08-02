import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String years;
  final String percentage;
  final Function()? ontap;
  final String date;

  const DoctorCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.years,
    required this.percentage,
    required this.date,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 12,
                          bottom: 7,
                        ),
                        child: image != null
                            ? Image.network(
                                image,
                                height: 80,
                                width: 85,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.asset('assets/images/blurblue.png')),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0XFF0EBE7F),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '$years Old',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff677294),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 13,
                                width: 13,
                                decoration: BoxDecoration(
                                    color: const Color(0XFF0EBE7F),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '$percentage%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff677294),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Clinic Address",
                        style: TextStyle(
                          color: Color(0XFF0EBE7F),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Color(0xff677294),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                InkWell(
                  onTap: ontap,
                  child: Container(
                    width: 110,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff0EBE7F),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
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
