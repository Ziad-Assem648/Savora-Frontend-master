import 'package:flutter/material.dart';
import 'dart:io';
import 'LanguageService.dart';
import 'MealItem.dart';
import 'main_layout.dart';

class MealDetailsPage extends StatefulWidget {
  final MealItem? meal;

  const MealDetailsPage({super.key, this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFFF724C);
    const Color textDark = Color(0xFF323643);
    const Color textGrey = Color(0xFF979797);
    const Color ingredientBg = Color(0xFFFFECE5);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      const Text(
                        "تفاصيل الوجبه",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryOrange,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F5FA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: PageView(
                            onPageChanged: (value) {
                              setState(() {
                                _currentPage = value;
                              });
                            },
                            children: [
                              _buildImage(widget.meal?.image1),
                              if (widget.meal?.image2 != null)
                                _buildImage(widget.meal?.image2),
                              if (widget.meal?.image3 != null)
                                _buildImage(widget.meal?.image3),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "حوادق",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        child: Row(
                          children: List.generate(
                            _getImageCount(),
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              height: 8,
                              width: _currentPage == index ? 20 : 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? primaryOrange
                                    : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.meal?.name ?? " طاجن لحمه",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryOrange,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: textGrey,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "اسوان",
                                style: TextStyle(color: textGrey, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.meal?.price ?? "150 ج.م",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryOrange,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                "(10 مراجعات)",
                                style: TextStyle(color: textGrey, fontSize: 12),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "4.9",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: primaryOrange,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "المكونات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryOrange,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildIngredientItem(
                          "فلفل",
                          Icons.local_fire_department_outlined,
                        ),
                        _buildIngredientItem("بصل", Icons.grass),
                        _buildIngredientItem("ثوم", Icons.spa_outlined),
                        _buildIngredientItem("فراخ", Icons.restaurant_menu),
                        _buildIngredientItem("ملح", Icons.grain),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "تفاصيل الوجبه",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryOrange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.meal?.description ??
                        "عكاوي بالخضار والبهارات و التوم و البصل و متسبكه في الفرن باليمنه البلدي. هذه الوجبة معدة بعناية فائقة لتناسب ذوقكم الرفيع.",
                    style: const TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 1),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MainLayout(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  // Fade + Slide animation
                                  final tween = Tween<Offset>(
                                    begin: const Offset(1.0, 0.0), // من اليمين
                                    end: Offset.zero,
                                  ).chain(CurveTween(curve: Curves.easeInOut));

                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    ),
                                  );
                                },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: const Text(
                          "تأكيد  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null) {
      return Image.asset("assets/images/meal_placeholder.png", fit: BoxFit.cover);
    }
    if (imagePath.startsWith('http')) {
      return Image.network(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('/') || imagePath.contains('\\')) {
      return Image.file(File(imagePath), fit: BoxFit.cover);
    } else {
      return Image.asset(imagePath, fit: BoxFit.cover);
    }
  }

  int _getImageCount() {
    int count = 1;
    if (widget.meal?.image2 != null) count++;
    if (widget.meal?.image3 != null) count++;
    return count;
  }

  Widget _buildIngredientItem(String name, IconData fallbackIcon) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFECE5),
              shape: BoxShape.circle,
            ),
            child: Icon(fallbackIcon, color: const Color(0xFFFF724C), size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF979797),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
