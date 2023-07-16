import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/core/data/repository/user_repository.dart';
import 'package:untitled4/view/shelter/shelter_route_page.dart';
import '../../core/data/entity/users.dart';

UserRepository userRepository = UserRepository();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User? get currentUser => _firebaseAuth.currentUser;

/// ---------------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light, // Varsayılan tema ayarı
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark, // Dark mode için tema ayarı
      ),
      home: const MyHomePage(),
    );
  }
}

/// ---------------------------------------------------------------------------

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userID = currentUser?.uid;

  String userPhotoURL = "";
  String userEmail = "";
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    // Veri tabanından currentAccountPicture, accountName ve accountEmail bilgilerini çekme işlemleri burada yapılabilir.
    // Örnek bir veri tabanı sorgusu:
    fetchUserDataFromDatabase();
  }

  void fetchUserDataFromDatabase() async{
    // Veri tabanından kullanıcı bilgilerini çekme işlemleri burada gerçekleştirilir.
    // Bu örnekte sabit değerler kullanarak simüle ediyoruz.

      Users? user = await userRepository.getUserSnapshotByID(userID!);

    setState(() {

      userPhotoURL = user!.photoURL![0];
      userEmail = user.email;

      //silinecek
      /*
      userPhotoURL =
      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250";
      userEmail = "aleyna.toprak5461@gmail.com";
      */
    });
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Center(child: Text("Ana Sayfa")),
      ),
      drawer: NavigationDrawer(
        userPhotoURL: userPhotoURL,
        userEmail: userEmail,
        isDarkMode: isDarkMode,
        onDarkModeToggle: toggleDarkMode,
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final String userPhotoURL;
  final String userEmail;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeToggle;
  const NavigationDrawer({
    required this.userPhotoURL,
    required this.userEmail,
    required this.isDarkMode,
    required this.onDarkModeToggle,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Arka planı beyaz yapar
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(userPhotoURL),
                      ),
                      accountEmail: Text(
                        userEmail,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      accountName: null,
                    ),
                    ListTile(
                      title: const Text(
                        "Ana Sayfa",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.home, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>const MyHomePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Barınaklar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.night_shelter,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>const ShelterRoutePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Blog",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.menu_book,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Blog(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Hayvanlar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.pets_sharp,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const FavoritedPets(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Hayvanlarım",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.pets, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const MyPet(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Veteriner",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.local_hospital,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Veteriner(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Bakımevleri",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.house, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Bakimevleri(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Mağaza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.store, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Magaza(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Kaydedilenler",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.folder,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Kaydedilenler(),
                          ),
                        );
                      },
                    ),
                    SwitchListTile(
                      title: const Text(
                        "Dark Mode",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      secondary: const Icon(Icons.dark_mode,
                          color: Colors.grey, size: 20),
                      value: isDarkMode,
                      onChanged: onDarkModeToggle,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Logout(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Barinaklar extends StatelessWidget {
  const Barinaklar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barınaklar"),
      ),
      body: const Center(child: Text("This is Barınaklar page")),
    );
  }
}

class Blog extends StatelessWidget {
  const Blog({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: const Center(child: Text("This is Blog page")),
    );
  }
}

class FavoritedPets extends StatelessWidget {
  const FavoritedPets({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hayvanlar"),
      ),
      body: const Center(child: Text("This is Hayvanlar page")),
    );
  }
}

class MyPet extends StatelessWidget {
  const MyPet({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hayvanlarım"),
      ),
      body: const Center(child: Text("This is Hayvanlarım page")),
    );
  }
}

class Veteriner extends StatelessWidget {
  const Veteriner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Veteriner"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/dog.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bakimevleri extends StatelessWidget {
  const Bakimevleri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bakimevleri"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/pet_loading.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Magaza extends StatelessWidget {
  const Magaza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Magaza"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/cute_dog.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//https://miro.medium.com/v2/resize:fit:640/1*zzTEyTwyy7jXibtqVWg84Q.gif

class Kaydedilenler extends StatelessWidget {
  const Kaydedilenler({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaydedilenler"),
      ),
      body: const Center(child: Text("This is Kaydedilenler page")),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logout"),
      ),
      body: const Center(child: Text("This is Logout page")),
    );
  }
}
