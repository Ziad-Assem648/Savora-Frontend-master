import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:savora_app/features/chef/orders/meal_details_page.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String selectedCategory = 'مشويات';
  final List<String> categories = ['مشويات', 'مأكولات بحرية', 'مقبلات', 'حلويات', 'مشروبات'];
  
  String unitType = 'وزن';
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  double price = 250;
  double quantity = 0.5;
  int preparationTime = 30;

  File? _image1;
  File? _image2;
  File? _image3;
  final ImagePicker _picker = ImagePicker();

  final Color primaryOrange = const Color(0xFFD84315);
  final Color lightOrangeBg = const Color(0xFFFBE9E7);
  final Color accentOrange = const Color(0xFFFFCCBC);
  final Color dottedBorderColor = const Color(0xFFE6AE9C);

  Future<void> _pickImage(int imageNumber) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else if (imageNumber == 2) {
          _image2 = File(pickedFile.path);
        } else if (imageNumber == 3) {
          _image3 = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF2F4F7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Text(
            "اضافه عنصر جديد",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              _buildSectionTitle("معلومات الطبق"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          isExpanded: true,
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  if (value == selectedCategory)
                                     Icon(Icons.lunch_dining, color: primaryOrange, size: 18),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _nameController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          hintText: "اسم الطبق",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildSectionTitle("صور المنتج"),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildUploadBox(
                    imageFile: _image1,
                    onTap: () => _pickImage(1),
                  ),
                  const SizedBox(width: 10),
                  _buildUploadBox(
                    imageFile: _image2,
                    onTap: () => _pickImage(2),
                  ),
                  const SizedBox(width: 10),
                   _buildUploadBox(
                    imageFile: _image3,
                    onTap: () => _pickImage(3),
                  ),





                  // Expanded(
                  //   child: Container(
                  //     height: 100,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       image: const DecorationImage(
                  //         image: NetworkImage("https://cdn.pixabay.com/photo/2017/09/30/15/10/plate-2802332_1280.jpg"),
                  //         fit: BoxFit.cover,
                  //       ),
                  //       border: Border.all(color: Colors.grey.shade300),
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _buildSectionTitle("الوصف الذكي", showLine: false),
                  const SizedBox(width: 5),
                  Icon(Icons.auto_awesome, size: 16, color: primaryOrange),
                  const SizedBox(width: 5),
                  Expanded(child: Container(height: 1, color: accentOrange)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightOrangeBg,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ضيف وصف تفصيلي علشان ال AI يعملك الصوره لو الصور عندك مش واضحه أو معندكش صور",
                      style: TextStyle(color: Color(0xFF8D6E63), fontSize: 12),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
                          label: const Text("انشاء الصوره", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD84315),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            elevation: 2,
                          ),
                        ),
                        Text(
                          "121 / 500",
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _buildSectionTitle("تفاصيل المنتج"),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      title: "السعر",
                      content: _buildCounterRow(
                        value: "$price",
                        unit: "ج.م",
                        onIncrement: () => setState(() => price += 10),
                        onDecrement: () => setState(() => price = (price - 10).clamp(0, 10000)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildDetailCard(
                      title: "الكمية",
                      content: _buildCounterRow(
                        value: "$quantity",
                        unit: "كيلو",
                        onIncrement: () => setState(() => quantity += 0.5),
                        onDecrement: () => setState(() => quantity = (quantity - 0.5).clamp(0, 100)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      title: "معيار الكميه",
                      content: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: accentOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _buildToggleButton("وزن", unitType == "وزن")),
                            Expanded(child: _buildToggleButton("عدد", unitType == "عدد")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildDetailCard(
                      title: "متوسط وقت التحضير",
                      content: _buildCounterRow(
                        value: "$preparationTime",
                        unit: "دقيقه",
                        onIncrement: () => setState(() => preparationTime += 5),
                        onDecrement: () => setState(() => preparationTime = (preparationTime - 5).clamp(0, 300)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildSectionTitle("الوصف"),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                     height: 120,
                     width: constraints.maxWidth,
                     child: Stack(
                       children: [
                         Positioned.fill(
                           child: CustomPaint(
                             painter: DottedBorderPainter(color: dottedBorderColor),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextField(
                             controller: _descriptionController,
                             maxLines: null,
                             expands: true,
                             textAlign: TextAlign.right,
                             style: const TextStyle(color: Color(0xFF5D4037), fontSize: 13),
                             decoration: const InputDecoration(
                               hintText: "اكتب وصف الوجبة هنا (المكونات، الطريقة...)",
                               hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                  );
                }
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    seconds: 1,
                                  ),
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => MealDetailsPage(),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        // Fade + Slide animation
                                        final tween =
                                            Tween<Offset>(
                                              begin: const Offset(
                                                1.0,
                                                0.0,
                                              ), // من اليمين
                                              end: Offset.zero,
                                            ).chain(
                                              CurveTween(
                                                curve: Curves.easeInOut,
                                              ),
                                            );

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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  child: const Text(
                    "حفظ الوجبه",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showLine = true}) {
    return Row(
      children: [
        if (showLine) ...[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: primaryOrange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: TextStyle(
            color: primaryOrange,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        if (showLine) ...[
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: accentOrange,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadBox({File? imageFile, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: lightOrangeBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: dottedBorderColor),
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: primaryOrange, size: 28),
                    const SizedBox(height: 5),
                    Text(
                      "اضافه",
                      style: TextStyle(color: primaryOrange.withOpacity(0.7), fontSize: 12),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDetailCard({required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF616161),
            ),
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildCounterRow({required String value, required String unit, required VoidCallback onIncrement, required VoidCallback onDecrement}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: accentOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onDecrement,
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove, size: 18, color: Color(0xFFD84315)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              Text(
                unit,
                style: const TextStyle(fontSize: 10, color: Colors.black54, height: 0.8),
              ),
            ],
          ),
          InkWell(
            onTap: onIncrement,
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, size: 18, color: Color(0xFFD84315)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          unitType = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  DottedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    ));

    Path dashPath = Path();
    double dashWidth = 5;
    double dashSpace = 3;
    double distance = 0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}