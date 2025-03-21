import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wefund/BottomNavigationBar.dart';
import 'package:wefund/DashboardPage.dart';
import 'package:wefund/IntroducingBrokerPage.dart';
import 'package:wefund/ThemeProvider.dart';
import 'package:wefund/copytreding.dart';
import 'package:wefund/fundscree.dart';
import 'package:wefund/fundspage.dart';
import 'package:wefund/pamm.dart';
import 'package:wefund/setting.dart';

class Account {
  int? userId;
  String? username;
  String? accountCategory;
  String? amount;
  String? platforms;
  String? accountName;

  Account({
    this.userId,
    this.username,
    this.accountCategory,
    this.amount,
    this.platforms,
    this.accountName,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      username: json['Username'] ?? 'Unknown',
      accountCategory: json['Account Category'] ?? 'N/A',
      amount: json['Amount'] ?? '0.00',
      platforms: json['Platforms'] ?? 'N/A',
      accountName: json['Account Name'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'Username': username,
      'Account Category': accountCategory,
      'Amount': amount,
      'Platforms': platforms,
      'Account Name': accountName,
    };
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   Account? account;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAccountData();
  }

  Future<void> fetchAccountData() async {
    final url = Uri.parse('https://wefundclient.com/Crm/Crm/Id_api.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is Map<String, dynamic>) {
          setState(() {
            account = Account.fromJson(jsonData);
            isLoading = false;
          });
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        throw Exception('Failed to load account data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
      print('Fetch error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<Map<String, dynamic>> settingsOptions = [
      {
        'icon': Icons.explore,
        'text': 'Dashboard',
        'color': Colors.green,
        'page': DashboardPage()
      },
      {
        'icon': Icons.groups,
        'text': 'Introducing Broker',
        'color': Colors.blue,
        'page': IntroducingBrokerPage()
      },
      {
        'icon': Icons.attach_money,
        'text': 'Funds',
        'color': Colors.amber,
        'page': FundsPage()
      },
      {'divider': true},
      {
        'icon': 'assets/crown.png', // Path to image
        'text': 'Copy Trading',
        'color': Colors.green,
        'page': CopyTradingPage(),
      },
      {
        'icon': 'assets/c.png', // Path to image
        'text': 'PAMM',
        'color': Colors.yellow,
        'page': PAMMPage()
      },
      {
        'icon': Icons.person,
        'text': 'Client Portal',
        'color': Colors.blue,
        'page': ClientPortalPage(),
      },
      {
        'icon': Icons.face,
        'text': 'Funded Account',
        'color': Colors.blue,
        'page': FundAccount(),
      },
      {'divider': true},
      {
        'icon': Icons.settings,
        'text': 'Settings',
        'color': Colors.green,
        'page': SettingsDetailsPage()
      },
      {
        'icon': Icons.question_mark,
        'text': 'Support',
        'color': Colors.yellow,
        'page': SupportPage()
      },
      {'themeToggle': true},
      {
        'icon': Icons.sync,
        'text': 'Update Available',
        'badge': true,
        'color': Colors.blue,
        'page': UpdatePage()
      },
      {
        'icon': 'assets/s.png', // Path to image
        'text': 'Privacy Policy',
        'color': Colors.blue,
        'page': PrivacyPolicyPage()
      },
      {
        'icon': 'assets/line.png', // Path to image
        'text': 'Delete Account',
        'color': Colors.red,
        'isDelete': true,
      },
      {
        'icon': Icons.logout,
        'text': 'Logout',
        'color': Colors.red,
        'isLogout': true,
      },
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
              fontSize: 22.px,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              themeProvider.isDarkMode ? Colors.black : Colors.white,
          iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        body: Column(children: [
          Column(
            children: [
              Image.asset(
                "assets/1.png",
                scale: 9.sp,
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AartiCapitalDetailsPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("WEFUND - Live",
                              style: TextStyle(
                                  fontSize: 16.px,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AartiCapitalDetailsPage()));
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.px,
                        color: Colors.grey,
                      )),
                  SizedBox(width: 6.w),
                ],
              ),
              SizedBox(height: 1.h),
                        
                            Text(
                           "Ac No : ${account?.accountName ?? 'N/A'}",
                              style: TextStyle(fontSize: 16.px),
                            ),
                            Text(
  "Balance : ₹${account?.amount ?? '0.00'}",
                              style: TextStyle(fontSize: 16.px),
                            ),
                          ],
                        ),
                     
              Expanded(
                child: ListView.builder(
                  itemCount: settingsOptions.length,
                  itemBuilder: (context, index) {
                    var item = settingsOptions[index];

                    if (item.containsKey('divider')) {
                      return Divider(
                        thickness: 6.w,
                        color: themeProvider.isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[300],
                      );
                    }

                    if (item.containsKey('themeToggle')) {
                      return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4), // Adjust padding

                          leading: Container(
                            width: 40, // Adjust as needed
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red, // Background color
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  8.0), // Adjust padding if needed
                              child: Image.asset(
                                'assets/contrast.png', // Asset image
                                fit: BoxFit.contain,
                                color: Colors.white, // Make image white
                              ),
                            ),
                          ),
                          title: Text("Default Theme"),
                          trailing: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      Colors.grey.shade300), // Add light border
                            ),
                            child: ToggleButtons(
                              borderColor: Colors.transparent,
                              selectedBorderColor: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(10),
                              isSelected: [
                                !themeProvider.isDarkMode,
                                themeProvider.isDarkMode
                              ],
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text("Light",
                                      style: TextStyle(fontSize: 14)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text("Dark",
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ],
                              onPressed: (index) {
                                themeProvider.toggleTheme(
                                    index == 1); // Set dark mode if index is 1
                              },
                            ),
                          ));
                    }

                    return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                        visualDensity: VisualDensity.compact,
                        tileColor: Colors.transparent,
                        shape: Border(
                            bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.8,
                        )),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: item['color'], // Background color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: item['icon'] is String
                              ? Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Adjust padding if needed
                                  child: Image.asset(
                                    item['icon'],
                                    fit: BoxFit.contain,
                                    color:
                                        Colors.white, // Apply white color tint
                                  ),
                                )
                              : Icon(item['icon'],
                                  color: Colors.white, size: 24),
                        ),
                        // White icon

                        title: Text(
                          item['text'],
                          style: TextStyle(fontSize: 18.px),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: 16.px, color: Colors.grey),
                        onTap: () {
                          if (item.containsKey('isDelete') &&
                              item['isDelete'] == true) {
                            _showDeleteConfirmationDialog(
                                context); // Show delete confirmation dialog
                          } else if (item.containsKey('isLogout') &&
                              item['isLogout'] == true) {
                            _showLogoutDialog(
                                context); // Show logout confirmation dialog
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => item['page']),
                            );
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(" Delete Account"),
          content: Text("Do you wish to close the account?"),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey background for cancel
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: Text("CANCEL", style: TextStyle(color: Colors.blue)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange, // Orange background for delete
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  // Navigate to Delete Account Page
                },
                child: Text("CONFIRM", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout Alert"),
        content: Text("Are you sure you want to exit the app?"),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300], // Grey background for cancel
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text("CANCEL", style: TextStyle(color: Colors.blue)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange, // Orange background for delete
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // Navigate to Delete Account Page
              },
              child: Text("EXIT", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      );
    },
  );
}

// class MAMPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("MAM")),
//       body: Center(child: Text("MAM Page")),
//     );
//   }
// }

class ClientPortalPage extends StatelessWidget {
  const ClientPortalPage({super.key});

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse('https://www.wefundglobalfx.com/copy-traders');

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Open in browser
      );
    } else {
      debugPrint("Could not open the link: $uri");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Client Portal",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // iOS-style back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              Container(
                height: 20.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/1.png"), // Ensure image exists
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 3.h), // Space between image and button

              // Create Account Button
              ElevatedButton(
                onPressed: _launchURL,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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


// Dummy Next Page
class NextPage extends StatefulWidget {
  const NextPage({
    super.key,
  });

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus(); // Hide keyboard

      // Navigate to the next screen after 1 second

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Login Page",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/1.png', height: 80),
                  SizedBox(height: 20),
                  Text("Login to WEFUND",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      labelText: "Email or Account ID",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                    ),
                    onPressed: _login,
                    child: Text("Log In",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  SizedBox(height: 10),

                  // Sign Up Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not Registered yet?",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(width: 5),
                        Text("Sign up",
                            style: TextStyle(fontSize: 18, color: Colors.blue))
                      ],
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
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/1.png', height: 80),
                  SizedBox(height: 20),
                  Text("Sign Up to WEFUND",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Enter your full name";
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: Colors.blue),
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) return "Enter your phone number";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                    ),
                    onPressed: _signup,
                    child: Text("Sign Up",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.off(() => NextPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        SizedBox(width: 5),
                        Text("Sign In",
                            style: TextStyle(fontSize: 18, color: Colors.blue))
                      ],
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
}

class SupportPage extends StatelessWidget {
  final String whatsappNumber =
      "+911234567890"; // Replace with actual WhatsApp number

  void openWhatsApp() async {
    String url = "https://wa.me/$whatsappNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), // iOS-style back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/WhatsApp.svg.png',
              height: 80), // Replace with correct image path
          SizedBox(height: 20),
          Text(
            "Getting in touch with our customer support team on WhatsApp",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: openWhatsApp,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              "Go to WhatsApp",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Available",
          style: TextStyle(
            fontSize: 22.px,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), // iOS-style back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          height: 30.h,
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/1.png", // Replace with your logo path
                height: 100,
              ),
              SizedBox(height: 2.h),
              Text(
                "Version 1.0.0",
                style: TextStyle(fontSize: 18.px, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(
                "Update Available Please Update Your\nAarti Capitals Application",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This privacy policy",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                "**Information Collection and Use**\n\n"
                "The Application collects information when you download and use it. This information may include: \n"
                "- Your device's IP address\n"
                "- The pages of the Application you visit, the time and date of your visit, and time spent on pages\n"
                "- The operating system you use\n"
                "- The Application does not gather precise location information\n\n"
                "**Third Party Access**\n\n"
                "Aggregated, anonymized data is periodically transmitted to external services to improve the app and service.\n"
                "The app uses third-party services with their own privacy policies: \n"
                "- [Google Play Services](https://www.google.com/policies/privacy/)\n\n"
                "**Opt-Out Rights**\n\n"
                "You can stop all collection of information by uninstalling the app.\n\n"
                "**Data Retention Policy**\n\n"
                "User data is retained as long as you use the app. To request data deletion, email WEFUND@gmail.com.\n\n"
                "**Children**\n\n"
                "The app does not knowingly collect data from children under 13. If you discover such data, contact WEFUND@gmail.com.\n\n"
                "**Security**\n\n"
                "The Service Provider implements safeguards to protect your information.\n\n"
                "**Changes**\n\n"
                "This Privacy Policy may be updated periodically. Continued use of the app implies consent to the updated policy.\n\n"
                "**Contact Us**\n\n"
                "For questions, contact WEFUND@gmail.com.\n\n"
                "*Privacy Policy effective as of 2025-02-24.*",
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AartiCapitalDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Sample data for accounts
    final List<Map<String, String>> accounts = [
      {"accountNo": "10009", "balance": "0.00"},
      {"accountNo": "10011", "balance": "0.00"},
      {"accountNo": "10010", "balance": "9999.60"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account List",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome WeFundedFX",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        "Account No : ${account['accountNo']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Balance : ${account['balance']}"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Handle on tap
                      },
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
