import 'package:flutter/material.dart';
import 'dart:io';
import 'LanguageService.dart';
import 'AddItemPage.dart';
import 'MealItem.dart';
import 'MealDetailsPage.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int selectedTab = 0;
  bool isGridView = false;
  bool isLoading = false;

  final List<String> tabs = [
    LanguageManager.isArabic ? "الكل" : "All",
    LanguageManager.isArabic ? "الدواجن" : "Poultry",
    LanguageManager.isArabic ? "المشروبات" : "Drinks",
    LanguageManager.isArabic ? "الحلويات" : "Desserts",
  ];

  // --- بيانات وهمية ---
  List<MealItem> allMeals = [
    MealItem(
      id: "1",
      name: "فراخ مشوية على الفحم",
      price: "150 ج.م",
      description: "فراخ مشوية على الفحم مع ارز وسلطة",
      image1:
          "https://cdn.pixabay.com/photo/2016/11/18/17/42/barbecue-1836053_1280.jpg",
      category: "Poultry",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
    MealItem(
      id: "2",
      name: "عصير برتقال فريش",
      price: "25 ج.م",
      description: "عصير فريش",
      image1:
          "https://cdn.pixabay.com/photo/2016/08/23/15/52/fresh-orange-juice-1614822_1280.jpg",
      category: "Drinks",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
    MealItem(
      id: "3",
      name: "كنافة بالمانجا",
      price: "80 ج.م",
      description: "كنافة بالمانجا",
      image1:
          "https://cdn.pixabay.com/photo/2017/05/07/08/56/pancakes-2291908_1280.jpg",
      category: "Desserts",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
    MealItem(
      id: "4",
      name: "شيش طاووق",
      price: "120 ج.م",
      description: "وجبة شيش طاووق",
      image1:
          "https://cdn.pixabay.com/photo/2022/06/22/16/10/skewer-7278278_1280.jpg",
      category: "Poultry",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
    MealItem(
      id: "5",
      name: "كولا باردة",
      price: "15 ج.م",
      description: "مشروب غازي",
      image1:
          "https://cdn.pixabay.com/photo/2014/09/26/19/51/drink-462776_1280.jpg",
      category: "Drinks",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
    MealItem(
      id: "6",
      name: "أرز بلبن",
      price: "30 ج.م",
      description: "أرز بلبن بالمكسرات",
      image1:
          "https://cdn.pixabay.com/photo/2016/01/22/02/13/ice-cream-1155103_1280.jpg",
      category: "Desserts",
      quantity: '',
      mainIngredients: [],
      extraIngredients: [],
    ),
  ];

  List<MealItem> displayedMeals = [];

  @override
  void initState() {
    super.initState();
    _filterMeals(0);
  }

  void _filterMeals(int index) {
    setState(() {
      selectedTab = index;
      if (index == 0) {
        displayedMeals = List.from(allMeals);
      } else {
        String filterKey = "";
        if (index == 1)
          filterKey = "Poultry";
        else if (index == 2)
          filterKey = "Drinks";
        else if (index == 3)
          filterKey = "Desserts";

        displayedMeals = allMeals
            .where((meal) => meal.category == filterKey)
            .toList();
      }
    });
  }

  // دالة الحذف
  Future<void> _deleteMeal(String mealId) async {
    bool confirmDelete =
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Directionality(
              textDirection: LanguageManager.textDirection,
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(
                  LanguageManager.isArabic ? 'تأكيد الحذف' : 'Confirm Delete',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  LanguageManager.isArabic
                      ? 'هل أنت متأكد أنك تريد حذف هذه الوجبة؟'
                      : 'Are you sure you want to delete this meal?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      LanguageManager.isArabic ? 'إلغاء' : 'Cancel',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      LanguageManager.isArabic ? 'حذف' : 'Delete',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;

    if (confirmDelete) {
      setState(() {
        allMeals.removeWhere((item) => item.id == mealId);
        _filterMeals(selectedTab);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageManager.isArabic
                ? 'تم حذف الوجبة بنجاح'
                : 'Meal deleted successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _navigateToDetails(MealItem meal) async {
    final updatedMeal = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealDetailsPage(meal: meal)),
    );

    if (updatedMeal != null && updatedMeal is MealItem) {
      setState(() {
        final index = allMeals.indexWhere(
          (element) => element.id == updatedMeal.id,
        );
        if (index != -1) {
          allMeals[index] = updatedMeal;
        }
        _filterMeals(selectedTab);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LanguageManager.isArabic ? 'تم حفظ التعديلات' : 'Changes saved',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageManager.textDirection,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(height: 15),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageManager.isArabic ? "الخدمات" : "Services",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isGridView ? Icons.list : Icons.grid_view,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {
                            isGridView = !isGridView;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Tabs
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      final bool isActive = (index == selectedTab);
                      return InkWell(
                        onTap: () => _filterMeals(index),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: isActive
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.orange,
                                      width: 3,
                                    ),
                                  ),
                                )
                              : null,
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isActive ? Colors.orange : Colors.grey,
                              fontSize: 16,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Content
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : displayedMeals.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fastfood_outlined,
                                size: 60,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                LanguageManager.isArabic
                                    ? "لا توجد وجبات هنا"
                                    : "No meals found",
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        )
                      : isGridView
                      ? GridView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.68,
                              ),
                          itemCount: displayedMeals.length,
                          itemBuilder: (_, index) {
                            return buildServiceCardFromMeal(
                              displayedMeals[index],
                              true,
                            );
                          },
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: displayedMeals.length,
                          itemBuilder: (_, index) {
                            return buildServiceCardFromMeal(
                              displayedMeals[index],
                              false,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddItemPage()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildServiceCardFromMeal(MealItem meal, bool isGrid) {
    String displayCategory = "";
    if (meal.category == "Poultry")
      displayCategory = LanguageManager.isArabic ? "الدواجن" : "Poultry";
    else if (meal.category == "Drinks")
      displayCategory = LanguageManager.isArabic ? "المشروبات" : "Drinks";
    else if (meal.category == "Desserts")
      displayCategory = LanguageManager.isArabic ? "الحلويات" : "Desserts";
    else
      displayCategory = LanguageManager.isArabic ? "وجبات" : "Meals";

    Widget imageWidget;
    if (meal.image1 != null && meal.image1!.isNotEmpty) {
      if (meal.image1!.startsWith("http")) {
        imageWidget = Image.network(
          meal.image1!,
          fit: BoxFit.cover,
          errorBuilder: (c, o, s) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      } else if (meal.image1!.startsWith("/")) {
        imageWidget = Image.file(File(meal.image1!), fit: BoxFit.cover);
      } else {
        imageWidget = Image.asset(
          meal.image1!,
          fit: BoxFit.cover,
          errorBuilder: (c, o, s) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        );
      }
    } else {
      imageWidget = Container(
        color: Colors.grey[200],
        child: const Icon(Icons.image, color: Colors.grey),
      );
    }

    // الـ GestureDetector الرئيسي للكارت
    return GestureDetector(
      onTap: () => _navigateToDetails(meal), // الانتقال لصفحة التعديل
      child: Container(
        margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 15),
        padding: isGrid ? EdgeInsets.zero : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isGrid
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: imageWidget,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          radius: 16,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () => _deleteMeal(meal.id),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              displayCategory,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                meal.price,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "4.9",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(width: 90, height: 90, child: imageWidget),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                meal.name,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () => _deleteMeal(meal.id),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            displayCategory,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.9 (50+)",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              meal.price,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// -------------------------------------------------------------
// صفحة تفاصيل الوجبة (MealDetailsPage) - قابلة للتعديل
// -------------------------------------------------------------
class MealDetailsPage extends StatefulWidget {
  final MealItem meal;
  const MealDetailsPage({super.key, required this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descController;
  // باقي الحقول...

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.meal.name);
    _priceController = TextEditingController(text: widget.meal.price);
    _descController = TextEditingController(text: widget.meal.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // إنشاء كائن جديد بالبيانات المعدلة
    final updatedMeal = MealItem(
      id: widget.meal.id,
      name: _nameController.text,
      price: _priceController.text,
      description: _descController.text,
      image1: widget.meal.image1,
      category: widget.meal.category,
      // ... باقي الحقول
      quantity: widget.meal.quantity,
      mainIngredients: widget.meal.mainIngredients,
      extraIngredients: widget.meal.extraIngredients,
    );

    // إرجاع البيانات للصفحة السابقة
    Navigator.pop(context, updatedMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageManager.textDirection,
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
            LanguageManager.isArabic ? "تفاصيل الوجبة" : "Meal Details",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الوجبة
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child:
                      widget.meal.image1 != null &&
                          widget.meal.image1!.startsWith("http")
                      ? Image.network(widget.meal.image1!, fit: BoxFit.cover)
                      : Image.asset(
                          "assets/images/Frame 794527.png",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 25),

              // حقول التعديل
              _buildTextField(
                label: LanguageManager.isArabic ? "اسم الوجبة" : "Meal Name",
                controller: _nameController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: LanguageManager.isArabic ? "السعر" : "Price",
                controller: _priceController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: LanguageManager.isArabic ? "الوصف" : "Description",
                controller: _descController,
                maxLines: 4,
              ),

              const SizedBox(height: 40),

              // زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD05024),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    LanguageManager.isArabic ? "حفظ التعديلات" : "Save Changes",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
  }
}
