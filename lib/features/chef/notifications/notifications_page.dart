import 'package:flutter/material.dart';
import 'package:savora_app/features/chef/shared/language_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            LanguageManager.isArabic ? "الإشعارات" : "Notifications",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // إشعار طلب جديد (قابل للضغط)
            _notificationItem(
              context,
              title: LanguageManager.isArabic ? "طلب جديد #1023" : "New Order #1023",
              description: LanguageManager.isArabic
                  ? "لديك طلب جديد من 'أحمد محمد' يحتوي على 3 وجبات."
                  : "You have a new order from 'Ahmed Mohamed'.",
              icon: Icons.shopping_bag_rounded,
              time: "منذ 2 دقيقة",
              isUnread: true,
              isOrder: true, // علامة لتمييز أنه طلب
            ),

            // إشعار قبول (معلومة فقط)
            _notificationItem(
              context,
              title: LanguageManager.isArabic ? "تم قبول الطلب" : "Order Accepted",
              description: LanguageManager.isArabic
                  ? "تم توصيل الطلب #1020 بنجاح للعميل."
                  : "Order #1020 delivered successfully.",
              icon: Icons.check_circle_rounded,
              time: "منذ 1 ساعة",
              isUnread: false,
              isOrder: false,
            ),

            // تنبيه نظام
            _notificationItem(
              context,
              title: LanguageManager.isArabic ? "تنبيه" : "Alert",
              description: LanguageManager.isArabic
                  ? "يرجى تحديث ساعات العمل الخاصة بك."
                  : "Please update your working hours.",
              icon: Icons.notifications_active_rounded,
              time: "منذ 3 ساعات",
              isUnread: false,
              isOrder: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required String time,
    bool isUnread = false,
    bool isOrder = false,
  }) {
    return GestureDetector(
      onTap: () {
        // إذا كان الإشعار عبارة عن "طلب"، نفتح صفحة التفاصيل
        if (isOrder) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationDetailsPage(
                title: title,
                time: time,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread ? const Color(0xFFFFF3E0) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isUnread
              ? Border.all(color: const Color(0xFFD84315).withOpacity(0.3))
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD84315).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFD84315), size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            // سهم صغير يدل على إمكانية الضغط إذا كان طلباً
            if (isOrder)
              const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// صفحة تفاصيل الإشعار (للقبول والرفض)
// ---------------------------------------------------------
class NotificationDetailsPage extends StatelessWidget {
  final String title;
  final String time;

  const NotificationDetailsPage({
    super.key,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "تفاصيل الطلب",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // معلومات العميل والوقت
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFF5F5F5),
                    child: Icon(Icons.person, color: Color(0xFFD84315)),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "العميل: أحمد محمد",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "قيد الانتظار",
                      style: TextStyle(
                        color: Color(0xFFD84315),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),

              // تفاصيل الوجبات
              const Text(
                "الطلبات:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              
              _buildOrderItem("2x فراخ مشوية", "300 ج.م"),
              _buildOrderItem("1x سلطة خضراء", "25 ج.م"),
              _buildOrderItem("2x بيبسي", "30 ج.م"),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              // العنوان والإجمالي
              const Text(
                "العنوان:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "أسوان، شارع الكورنيش، عمارة 5، الدور الثالث.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const Spacer(),

              // الإجمالي الكلي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الإجمالي الكلي",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "355 ج.م",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD84315),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),

              // أزرار القبول والرفض
              Row(
                children: [
                  // زر الرفض
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // منطق الرفض هنا
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم رفض الطلب")),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "رفض",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // زر القبول
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // منطق القبول هنا
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("تم قبول الطلب بنجاح"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "قبول الطلب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}