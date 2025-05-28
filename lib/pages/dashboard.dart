import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../assets/components/grocery_item_tile.dart';
import '../assets/model/cart_model.dart';
import 'cart_page.dart';
import 'login_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      Fluttertoast.showToast(
        msg: "Logged out successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to log out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Icon(
                  Icons.location_on,
                  color: Colors.grey[700],
                ),
              ),
              title: Text(
                'Accra, Ghana',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: _signOut,
                    tooltip: 'Logout',
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartPage();
                  },
                ),
              ),
              child: const Icon(Icons.shopping_bag),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),

                // good morning bro
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('Good morning,'),
                ),

                const SizedBox(height: 4),

                // Let's order fresh items for you
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Let's order fresh items for you",
                    style: GoogleFonts.notoSerif(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Divider(),
                ),

                const SizedBox(height: 24),

                // categories -> horizontal listview
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Fresh Items",
                    style: GoogleFonts.notoSerif(
                      fontSize: 18,
                    ),
                  ),
                ),

                // recent orders -> show last 3
                Expanded(
                  child: Consumer<CartModel>(
                    builder: (context, value, child) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.shopItems.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.2,
                        ),
                        itemBuilder: (context, index) {
                          return GroceryItemTile(
                            itemName: value.shopItems[index][0],
                            itemPrice: value.shopItems[index][1],
                            imagePath: value.shopItems[index][2],
                            color: value.shopItems[index][3],
                            onPressed: () =>
                                Provider.of<CartModel>(context, listen: false)
                                    .addItemToCart(index),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}