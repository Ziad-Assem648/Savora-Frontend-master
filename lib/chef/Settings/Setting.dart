import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:savora_app/features/customer/auth/screens/login_screen.dart';


// ---------------------------------------------------------
// 1. الصفحة الرئيسية: الإعدادات (SettingChefs)
// ---------------------------------------------------------

class SettingChefs extends StatefulWidget {
  const SettingChefs({super.key});

  @override
  State<SettingChefs> createState() => _SettingChefsState();
}

class _SettingChefsState extends State<SettingChefs> {
  
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD05024),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ملفك الشخصي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            const Text(
                              "Ziad Assem",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ProfileCardGroup(
                              items: [
                                ProfileItem(
                                  title: "معلوماتك الشخصيه",
                                  icon: Icons.person_outline,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                                  },
                                ),
                                ProfileItem(
                                  title: "العناوين",
                                  icon: Icons.map_outlined,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressPage()));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ProfileCardGroup(
                              items: [
                                ProfileItem(
                                  title: "الإعدادات",
                                  icon: Icons.settings_outlined,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AppSettingsPage()));
                                  },
                                ),
                                ProfileItem(
                                  title: "طرق الدفع",
                                  icon: Icons.credit_card,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsPage()));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ProfileCardGroup(
                              items: [
                                ProfileItem(
                                  title: "تسجيل الخروج",
                                  icon: Icons.logout,
                                  isRedIcon: true,
                                  onTap: () {
                                    showLogoutConfirmation(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/newlogo.png"),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.logout, size: 50, color: Color(0xFFD05024)),
              const SizedBox(height: 15),
              const Text(
                "تأكيد تسجيل الخروج",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "هل أنت متأكد أنك تريد تسجيل الخروج؟",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("إلغاء", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _logout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD05024),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("خروج", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------
// 2. ويدجت "الهيكل الموحد" (Base Scaffold) لتوحيد التصميم
// ---------------------------------------------------------

class ChefBasePage extends StatelessWidget {
  final String title;
  final Widget child;

  const ChefBasePage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD05024),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. صفحة تعديل الملف الشخصي (EditProfilePage)
// ---------------------------------------------------------

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChefBasePage(
      title: "تعديل الملف الشخصي",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/images/newlogo.png"),
                  backgroundColor: Colors.grey,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD05024),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildTextField(label: "الاسم الكامل", initialValue: "Ziad Assem ", icon: Icons.person),
            const SizedBox(height: 20),
            _buildTextField(label: "رقم الهاتف", initialValue: "01120730109", icon: Icons.phone),
            const SizedBox(height: 20),
            _buildTextField(label: "البريد الإلكتروني", initialValue: "ziad@gmail.com", icon: Icons.email),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD05024),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("حفظ التغييرات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String initialValue, required IconData icon}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFD05024)),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFD05024)),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. صفحة العناوين (AddressPage)
// ---------------------------------------------------------

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChefBasePage(
      title: "العناوين المسجلة",
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAddressCard("المنزل", "شارع التأمين، اسوان، مصر", true),
                const SizedBox(height: 15),
                _buildAddressCard("العمل", " الرضوان، اسوان، مصر", false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("إضافة عنوان جديد", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD05024),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(String title, String details, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF3CDB6).withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isSelected ? const Color(0xFFD05024) : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: const Color(0xFFD05024), size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(details, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: Color(0xFFD05024)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. صفحة الإعدادات (AppSettingsPage)
// ---------------------------------------------------------

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return ChefBasePage(
      title: "إعدادات التطبيق",
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: const Text("الإشعارات", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("تفعيل أو تعطيل التنبيهات"),
            value: _notifications,
            activeColor: const Color(0xFFD05024),
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("تغيير كلمة المرور", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.lock_outline, color: Color(0xFFD05024)),
            trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text("اللغة", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.language, color: Color(0xFFD05024)),
            trailing: const Text("العربية", style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text("سياسة الخصوصية", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFFD05024)),
            trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 6. صفحة طرق الدفع (PaymentMethodsPage)
// ---------------------------------------------------------

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChefBasePage(
      title: "طرق الدفع",
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // كارت الفيزا
                Container(
                  height: 180,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("VISA", style: TextStyle(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                          Icon(Icons.nfc, color: Colors.white),
                        ],
                      ),
                      const Text("**** **** **** 1234", style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2)),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("MESSI 10", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          Text("12/25", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text("طرق دفع أخرى", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildPaymentTile("فودافون كاش", Icons.phone_android),
                _buildPaymentTile("الدفع عند الاستلام", Icons.money),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_card, color: Colors.white),
                label: const Text("إضافة بطاقة جديدة", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD05024),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 30),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------
// 7. الودجات المساعدة (Widgets) المشتركة
// -----------------------------------------------------------

class ProfileItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isRedIcon;

  ProfileItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isRedIcon = false,
  });
}

class ProfileCardGroup extends StatelessWidget {
  final List<ProfileItem> items;

  const ProfileCardGroup({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3CDB6), 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: items.map((item) {
          int index = items.indexOf(item);
          bool isLast = index == items.length - 1;

          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.icon,
                          color: item.isRedIcon ? Colors.red : const Color(0xFFD05024), 
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black45,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                 Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.brown.withOpacity(0.2),
                  indent: 70, 
                  endIndent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}