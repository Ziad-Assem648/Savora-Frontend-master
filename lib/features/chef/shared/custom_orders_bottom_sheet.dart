import 'package:flutter/material.dart';
import 'package:savora_app/features/chef/shared/language_service.dart';


class OrdersBottomSheet extends StatelessWidget {
  const OrdersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageManager.textDirection,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              LanguageManager.isArabic
                  ? "الطلبات المطلوبه الان"
                  : "Current Orders",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    child: Row(
                      textDirection: LanguageManager.textDirection,
                      children: [
                        // الصورة
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/Frame 794525.png",
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: LanguageManager.isArabic ? 15.0 : 0,
                              left: LanguageManager.isArabic ? 0 : 15.0,
                            ),
                            child: Column(
                              crossAxisAlignment: LanguageManager.isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LanguageManager.isArabic
                                      ? "حلويات"
                                      : "Desserts",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  LanguageManager.isArabic
                                      ? "كنافه بالقشطة"
                                      : "Kunafa with Cream",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  LanguageManager.isArabic
                                      ? "60 ج.م"
                                      : "60 EGP",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  textDirection: LanguageManager.textDirection,
                                  mainAxisAlignment: LanguageManager.isArabic
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        LanguageManager.isArabic
                                            ? "قبول"
                                            : "Accept",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        LanguageManager.isArabic
                                            ? "الغاء"
                                            : "Cancel",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
