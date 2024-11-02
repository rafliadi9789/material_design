import 'package:flutter/material.dart';

/// Item untuk FlashyTabBar
class FlashyTabBarItem {
  FlashyTabBarItem({
    required this.icon,
    required this.title,
    this.activeColor = const Color(0xff272e81),
    this.inactiveColor = const Color(0xff9496c1),
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color inactiveColor;
}

class FlashyTabBar extends StatelessWidget {
  const FlashyTabBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.backgroundColor,
    this.showElevation = true,
    this.iconSize = 24,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final List<FlashyTabBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;
  final bool showElevation;
  final double iconSize;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: showElevation ? [BoxShadow(color: Colors.black12, blurRadius: 5)] : [],
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              int index = items.indexOf(item);
              bool isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTheme(
                      data: IconThemeData(
                        size: iconSize,
                        color: isSelected ? item.activeColor : item.inactiveColor,
                      ),
                      child: item.icon,
                    ),
                    if (isSelected && item.title is Text)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        child: item.title,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<FlashyTabBarItem> _items = [
    FlashyTabBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    FlashyTabBarItem(
      icon: Icon(Icons.search),
      title: Text('Search'),
    ),
    FlashyTabBarItem(
      icon: Icon(Icons.notifications),
      title: Text('Notifications'),
    ),
    FlashyTabBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    ),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rafli Food',
          style: TextStyle(
            color: Color(0xFF4A90E2),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Color(0xFF4A90E2)),
            onPressed: () {
              // Aksi untuk ikon profil
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF4A90E2),
              ),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigasi ke halaman lain atau aksi lainnya
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigasi ke halaman pengaturan
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFF4A90E2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Aksi pencarian
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rekomendasi Kami!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 300, // Sesuaikan tinggi agar menampung gambar dan teks
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecommendationCard(
                  'assets/images/nasikuning.jpg',
                  'Nasi Kuning',
                  'Rating 4.9 / 5.0',
                  'Nasi Kuning & Lalapan Khas Jakarta',
                ),
                _buildRecommendationCard(
                  'assets/images/bakso.jpg',
                  'Bakso',
                  'Rating 4.8 / 5.0',
                  'Mie Ayam dan Bakso Pak Imin Khas Wonogiri',
                ),
                _buildRecommendationCard(
                  'assets/images/nasigoreng.jpg',
                  'Nasi Goreng',
                  'Rating 4.7 / 5.0',
                  'Nasi Goreng Seafood Spesial Khas Chinese Food',
                ),
                _buildRecommendationCard(
                  'assets/images/sopdaging.jpg',
                  'Sop Daging',
                  'Rating 4.8 / 5.0',
                  'Sop Daging Janda dengan porsi melimpah',
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Ini adalah Tab ${_selectedIndex + 1}',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        items: _items,
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }

  Widget _buildRecommendationCard(String assetImagePath, String title,
      String subtitle, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Container(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              assetImagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Aksi untuk tombol Pesan!
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A90E2), // Warna tombol biru
                  foregroundColor: Colors.white,// Warna teks tombol
                ),
                child: Text('Pesan!'),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
