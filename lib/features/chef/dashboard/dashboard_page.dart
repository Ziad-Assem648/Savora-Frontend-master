import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:savora_app/features/chef/shared/language_service.dart';
import 'package:savora_app/features/chef/shared/location_service.dart';
import 'package:savora_app/features/chef/shared/add_item_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int maxOrders = 50;

  bool isMaxOrdersSet = false;
  bool isLocationSet = false;
  bool isHealthCertSet = false;
  bool isIdSet = false;
  bool isAccountVerified = false;

  File? frontIDImage;
  File? backIDImage;
  File? healthCertificateImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedState(); // تحميل البيانات المحفوظة عند فتح الصفحة
  }

  // --- دالة تحميل البيانات المحفوظة ---
  Future<void> _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      maxOrders = prefs.getInt('maxOrders') ?? 50;
      isMaxOrdersSet = prefs.getBool('isMaxOrdersSet') ?? false;
      isLocationSet = prefs.getBool('isLocationSet') ?? false;
      isHealthCertSet = prefs.getBool('isHealthCertSet') ?? false;
      isIdSet = prefs.getBool('isIdSet') ?? false;
      isAccountVerified = prefs.getBool('isAccountVerified') ?? false;

      // تحميل مسارات الصور إذا وجدت
      String? frontPath = prefs.getString('frontIDImage');
      if (frontPath != null) frontIDImage = File(frontPath);

      String? backPath = prefs.getString('backIDImage');
      if (backPath != null) backIDImage = File(backPath);

      String? healthPath = prefs.getString('healthCertificateImage');
      if (healthPath != null) healthCertificateImage = File(healthPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                const SizedBox(height: 30),

                // إخفاء الخطوات فقط إذا تم تفعيل الحساب
                if (!isAccountVerified) ...[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 32,
                      ),
                      child: buildStepsSection(context),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],

                buildStatsRow(),
                const SizedBox(height: 20),
                buildGraphCard(),
                const SizedBox(height: 20),
                buildRatingCard(),
                const SizedBox(height: 20),
                isAccountVerified
                    ? buildPopularDishesFilled()
                    : buildPopularDishesEmptyState(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        if (isAccountVerified)
          const Icon(Icons.menu, size: 30, color: Colors.black),

        if (isAccountVerified) ...[
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: const [
              Text(
                "العنوان",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "اسوان ,شارع التأمين",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          const Spacer(),
        ] else ...[
          Row(
            children: const [
              Icon(Icons.arrow_drop_down, color: Colors.black54),
              SizedBox(width: 5),
              Text(
                "العنوان",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],

        const Spacer(),

        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 2),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/chef_avatar.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStepsSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (isMaxOrdersSet && isLocationSet && isHealthCertSet && isIdSet) {
              showPendingApprovalDialog(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("يرجى إكمال جميع الخطوات السابقة أولاً"),
                ),
              );
            }
          },
          child: buildSingleStep(
            icon: Icons.verified,
            label: "انتظار التأكيد",
            color: const Color(0xFFE65100),
            isOutlined: true,
            showBadge: false,
          ),
        ),
        buildStepConnector(isDashed: true),
        GestureDetector(
          onTap: () {
            showIDVerificationBottomSheet(context);
          },
          child: buildSingleStep(
            icon: Icons.credit_card,
            label: "صورة الرقم\nالقومي",
            color: const Color(0xFFE6A696),
            isOutlined: !isIdSet,
            showBadge: isIdSet,
            iconColor: isIdSet ? Colors.white : const Color(0xFFE65100),
            fillColor: isIdSet ? const Color(0xFFE65100) : null,
          ),
        ),
        buildStepConnector(isDashed: true),
        GestureDetector(
          onTap: () {
            showHealthCertificateBottomSheet(context);
          },
          child: buildSingleStep(
            icon: Icons.medical_services_outlined,
            label: "الشهادة\nالصحية",
            color: const Color(0xFFE6A696),
            isOutlined: !isHealthCertSet,
            showBadge: isHealthCertSet,
            iconColor: isHealthCertSet ? Colors.white : const Color(0xFFE65100),
            fillColor: isHealthCertSet ? const Color(0xFFE65100) : null,
          ),
        ),
        buildStepConnector(isDashed: false),
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocationService()),
            );
            // حفظ حالة الموقع
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLocationSet', true);
            setState(() {
              isLocationSet = true;
            });
          },
          child: buildSingleStep(
            icon: Icons.location_on,
            label: "حدد مكانك\nعلى الخريطة",
            color: const Color(0xFFE65100),
            isOutlined: !isLocationSet,
            showBadge: isLocationSet,
            iconColor: isLocationSet ? Colors.white : const Color(0xFFE65100),
            fillColor: isLocationSet ? const Color(0xFFE65100) : null,
          ),
        ),
        buildStepConnector(isDashed: false),
        GestureDetector(
          onTap: () {
            showMaxOrdersBottomSheet(context);
          },
          child: buildSingleStep(
            icon: Icons.shopping_bag,
            label: "أقصى عدد\nطلبات",
            color: const Color(0xFFE65100),
            isOutlined: !isMaxOrdersSet,
            showBadge: isMaxOrdersSet,
            iconColor: isMaxOrdersSet ? Colors.white : const Color(0xFFE65100),
            fillColor: isMaxOrdersSet ? const Color(0xFFE65100) : null,
          ),
        ),
      ],
    );
  }

  void showPendingApprovalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "حالة الطلب",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 40,
                    color: Color(0xFFE65100),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "جاري مراجعة بياناتك",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "سيقوم فريقنا بمراجعة المستندات والبيانات\nالمدخلة وتفعيل حسابك في خلال 24 ساعة",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "إغلاق",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // حفظ حالة التفعيل
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isAccountVerified', true);

                      setState(() {
                        isAccountVerified = true;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65100),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "تفعيل الحساب فوراً (للتجربة)",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showHealthCertificateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateSheet) {
            Future<void> pickImage() async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                setStateSheet(() {
                  healthCertificateImage = File(image.path);
                });
              }
            }

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "الشهادة الصحية",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[100],
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFD6E4FF)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2979FF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "يرجى رفع صورة واضحة للشهادة الصحية سارية المفعول لضمان قبول الطلب.",
                            style: TextStyle(
                              color: Color(0xFF3F51B5),
                              fontSize: 12,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: pickImage,
                    child: CustomPaint(
                      painter: DashedRectPainter(
                        color: Colors.grey.shade400,
                        gap: 4,
                        strokeWidth: 1,
                      ),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: healthCertificateImage != null
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: FileImage(healthCertificateImage!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                        child: healthCertificateImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: const Color(0xFFF5F5F5),
                                    child: Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.grey.shade600,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "اضغط لرفع صورة الشهادة",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        // حفظ البيانات
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isHealthCertSet', true);
                        if (healthCertificateImage != null) {
                          await prefs.setString(
                            'healthCertificateImage',
                            healthCertificateImage!.path,
                          );
                        }

                        setState(() {
                          isHealthCertSet = true;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "إرسال للمراجعة",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showIDVerificationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateSheet) {
            Future<void> pickImage(bool isFront) async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                setStateSheet(() {
                  if (isFront) {
                    frontIDImage = File(image.path);
                  } else {
                    backIDImage = File(image.path);
                  }
                });
              }
            }

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "التحقق من الهوية",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[100],
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFD6E4FF)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2979FF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "يرجى التأكد من وضوح الصورة وظهور كافة البيانات بشكل صحيح لسرعة التفعيل.",
                            style: TextStyle(
                              color: Color(0xFF3F51B5),
                              fontSize: 12,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(true),
                          child: _buildUploadBox(
                            title: "الوجه الأمامي",
                            icon: Icons.camera_alt_outlined,
                            imageFile: frontIDImage,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(false),
                          child: _buildUploadBox(
                            title: "الوجه الخلفي",
                            icon: Icons.cloud_upload_outlined,
                            imageFile: backIDImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        // حفظ البيانات
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isIdSet', true);
                        if (frontIDImage != null)
                          await prefs.setString(
                            'frontIDImage',
                            frontIDImage!.path,
                          );
                        if (backIDImage != null)
                          await prefs.setString(
                            'backIDImage',
                            backIDImage!.path,
                          );

                        setState(() {
                          isIdSet = true;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "إرسال للمراجعة",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUploadBox({
    required String title,
    required IconData icon,
    File? imageFile,
  }) {
    return CustomPaint(
      painter: DashedRectPainter(
        color: Colors.grey.shade400,
        gap: 4,
        strokeWidth: 1,
      ),
      child: Container(
        height: 110,
        alignment: Alignment.center,
        decoration: imageFile != null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: FileImage(imageFile),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFF5F5F5),
                    child: Icon(icon, color: Colors.grey.shade600, size: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  void showMaxOrdersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateSheet) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "تحديد عدد الطلبات",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[100],
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFECB3).withOpacity(0.5),
                      ),
                    ),
                    child: const Text(
                      "قم بتحديد الحد الأقصى للطلبات التي يمكنك\nتحضيرها يومياً لضمان جودة الخدمة.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8D6E63),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "عدد الطلبات اليومي",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263238),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setStateSheet(() {
                            maxOrders++;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE0B2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFFE65100),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFFE0B2)),
                          ),
                          child: Text(
                            "$maxOrders",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (maxOrders > 0) {
                            setStateSheet(() {
                              maxOrders--;
                            });
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        // حفظ البيانات
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isMaxOrdersSet', true);
                        await prefs.setInt('maxOrders', maxOrders);

                        setState(() {
                          isMaxOrdersSet = true;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "حفظ التغييرات",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSingleStep({
    required IconData icon,
    required String label,
    required Color color,
    bool isOutlined = false,
    bool showBadge = false,
    Color iconColor = const Color(0xFFE65100),
    Color? fillColor,
  }) {
    return Container(
      width: 70,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: fillColor ?? (isOutlined ? Colors.white : color),
                  border: isOutlined
                      ? Border.all(color: color, width: 2)
                      : null,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              if (showBadge)
                Positioned(
                  top: 0,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFF00C853),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStepConnector({required bool isDashed}) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 30),
      child: isDashed
          ? CustomPaint(painter: DashedLinePainter())
          : Container(color: const Color(0xFFE65100)),
    );
  }

  Widget buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              color: isAccountVerified ? Colors.white : const Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAccountVerified ? "20" : "0",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "الطلبات المكتملة",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD84315),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              color: isAccountVerified ? Colors.white : const Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAccountVerified ? "05" : "0",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "الطلبات المطلوبه الان",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD84315),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGraphCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isAccountVerified ? Colors.white : const Color(0xFFF4C6B6),
        borderRadius: BorderRadius.circular(25),
        border: isAccountVerified
            ? null
            : Border.all(color: const Color(0xFF2979FF), width: 2),
        boxShadow: isAccountVerified
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "رؤيه المزيد",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFFD84315),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "يومى",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "الاجمالي",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      isAccountVerified ? "2,241 ج.م" : "0 ج.م",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isAccountVerified
                    ? [Colors.white, Colors.white]
                    : [
                        const Color(0xFFE58E73).withOpacity(0.9),
                        const Color(0xFFE58E73).withOpacity(0.7),
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "${value.toInt()}/2",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 1,
                maxX: 7,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: isAccountVerified
                        ? const [
                            FlSpot(1, 1),
                            FlSpot(2, 2.5),
                            FlSpot(3, 1.8),
                            FlSpot(4, 3.5),
                            FlSpot(5, 2.2),
                            FlSpot(6, 4.0),
                            FlSpot(7, 3.2),
                          ]
                        : const [
                            FlSpot(1, 3),
                            FlSpot(2, 3),
                            FlSpot(3, 3),
                            FlSpot(4, 3),
                            FlSpot(5, 3),
                            FlSpot(6, 3),
                            FlSpot(7, 3),
                          ],
                    isCurved: isAccountVerified,
                    color: const Color(0xFFFF5722),
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: isAccountVerified,
                      color: const Color(0xFFFF5722).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildRatingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isAccountVerified ? Colors.white : const Color(0xFFFBE9E7),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "التقييمات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "مشاهده الجميع",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xFFD84315),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFF7043), size: 30),
                  const SizedBox(width: 8),
                  Text(
                    isAccountVerified ? "4.9" : "0.0",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF7043),
                    ),
                  ),
                ],
              ),
              Text(
                isAccountVerified
                    ? "اجمالي المراجعات : 39"
                    : "لم يتم تقيمك حتى الان",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPopularDishesEmptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE9E7),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "الاطباق الرائجه هذا الاسبوع",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "رؤيه المزيد",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xFFD84315),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomPaint(
            painter: DashedRectPainter(
              color: const Color(0xFFD84315),
              strokeWidth: 1.5,
              gap: 4.0,
            ),
            child: Container(
              height: 180,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "لم تقم بإضافة أي طبق حتى الآن",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddItemPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF3E0),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "+ إضافة طبق جديد",
                      style: TextStyle(
                        color: Color(0xFFD84315),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPopularDishesFilled() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "الاطباق الرائجه هذا الاسبوع",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "رؤيه المزيد",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xFFD84315),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/chef_dish_1.png",
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/chef_dish_2.png",
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5;
    double dashSpace = 3;
    double startX = 0;
    final paint = Paint()
      ..color = const Color(0xFFD84315)
      ..strokeWidth = 2;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  DashedRectPainter({
    this.strokeWidth = 1.0,
    this.color = Colors.red,
    this.gap = 5.0,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    double x = size.width;
    double y = size.height;
    double radius = 20.0;
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, x, y),
          Radius.circular(radius),
        ),
      );
    Path dashedPath = Path();
    double dashWidth = 8.0;
    double dashSpace = gap;
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashedPath, dashedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
