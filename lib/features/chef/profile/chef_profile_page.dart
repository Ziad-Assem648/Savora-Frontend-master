import 'package:flutter/material.dart';
import 'package:savora_app/features/chef/shared/language_service.dart';

class ChefProfilePage extends StatefulWidget {

  const ChefProfilePage({super.key,});

  @override
  State<ChefProfilePage> createState() => _ChefProfilePageState();
}

class _ChefProfilePageState extends State<ChefProfilePage> {
  bool isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageManager.textDirection,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1220),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D1220),
          title: Text(
            LanguageManager.isArabic ? "الملف الشخصي" : "Profile",
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              LanguageManager.isArabic ? Icons.arrow_forward : Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isEditing ? Icons.check : Icons.edit,
                color: Colors.orange,
              ),
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    // Save changes
                    _saveProfile();
                  }
                  isEditing = !isEditing;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Name field
              _buildProfileField(
                LanguageManager.isArabic ? "الاسم" : "Name",
                _nameController,
                isEditing,
              ),
              const SizedBox(height: 20),
              // Email field
              _buildProfileField(
                LanguageManager.isArabic ? "البريد الإلكتروني" : "Email",
                _emailController,
                false, // Email shouldn't be editable
              ),
              const SizedBox(height: 20),
              // Phone field
              _buildProfileField(
                LanguageManager.isArabic ? "رقم الهاتف" : "Phone",
                _phoneController,
                isEditing,
              ),
              const SizedBox(height: 20),
              // Address field
              _buildProfileField(
                LanguageManager.isArabic ? "العنوان" : "Address",
                _addressController,
                isEditing,
              ),
              const SizedBox(height: 30),
              // Stats cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      "50",
                      LanguageManager.isArabic ? "الطلبات" : "Orders",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      "4.9",
                      LanguageManager.isArabic ? "التقييم" : "Rating",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Action buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle view menu
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    LanguageManager.isArabic ? "عرض القائمة" : "View Menu",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle logout
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    LanguageManager.isArabic ? "تسجيل الخروج" : "Logout",
                    style: const TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller,
    bool editable,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: editable,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F2937),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    // Implement save profile logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LanguageManager.isArabic ? "تم حفظ الملف الشخصي" : "Profile saved",
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
