import 'package:flutter/material.dart';

import 'view/cart/cart_page.dart';
import 'view/product/product_page.dart';
import 'view/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  static List<Widget> listPage = [
    ProductPage(),
    const ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[selectedIndex],
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: cartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: selectedIndex,
              onTap: onItemTapped,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Image.asset(
                      'assets/images/Home.png',
                      width: 18,
                      color: selectedIndex == 0
                          ? Colors.green
                          : const Color(0xff808191),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top: 3, right: 20),
                    child: Center(
                      child: Image.asset(
                        'assets/images/Profile.png',
                        width: 16,
                        color: selectedIndex == 1
                            ? Colors.green
                            : const Color(0xff808191),
                      ),
                    ),
                  ),
                  label: '',
                ),
              ]),
        ),
      ),
    );
  }
}

Widget cartButton(BuildContext context) {
  return FloatingActionButton(
    shape: const CircleBorder(),
    backgroundColor: Color.fromARGB(255, 52, 246, 104),
    child: Image.asset(
      'assets/images/Cart-Icon.png',
      width: 24,
    ),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const CartPage();
      }));
    },
  );
}