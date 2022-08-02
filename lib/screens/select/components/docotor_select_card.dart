import 'package:flutter/material.dart';

class DoctorSelectCard extends StatelessWidget {
  final String image;
  final String title;
  const DoctorSelectCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        const Text(
                          "University Dental Clinic, salt lake",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0XFF677294),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Color(0XffFFCF68),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XffFFCF68),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XffFFCF68),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XffFFCF68),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XffFFCF68),
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
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
        ),
      ),
    );
  }
}
