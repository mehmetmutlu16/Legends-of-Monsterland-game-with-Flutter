import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/homePage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _candy = 10;
  final _energy = 20;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        await _onGoogleSignInSuccess(context, googleUser);
      } else {
        _onGoogleSignInCancel();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onGoogleSignInSuccess(
      BuildContext context, GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final userData = {
          'candy': _candy,
          'energy': _energy,
          'email': user.email,
          'florass': false,
          'sparkie': false,
          'sparken': false,
          'aquadra': false,
          'shockwing': false,
          'zapwing': false,
          'joltur': false,
          'joltrik': false,
          'mysticon': false,
          'psypup': false,
          'psydog': false,
          'dolphineon': false,
          'rockslide': false,
          'rockfist': false,
          'silentpaw': false,
          'shadowclaw': false,
          'electromon': false,
          'eaglestorm': false,
          'skywing': false,
          'woolie': false,
          'wooliec': false,
          'wooliectra': false,
          'spookums': false,
          'spookram': false,
          'nimowl': false,
          'wisowl': false,
          'fliefox': false,
          'fluffox': false,
          'drogie': false,
          'drogice': false,
          'drogrost': false,
          'monrass': false,
          'gorrass': false,
          'flamerock': false,
          'flameburst': false,
          'vaseblade': false,
          'leafblade': false,
          'forestblade': false,
          'glimmer': false,
          'schimmer': false,
          'dunebelle': false,
          'infernus': false,
          'blazenus': false,
          'whispurr': false,
          'ghosteroid': false,
          'toxibug': false,
          'toxiban': false,
          'citrusclaw': false,
          'gingerpaw': false,
          'poliba': false,
          'skov': false,
          'skovie': false,
          'rhinohorn': false,
          'rhinorock': false,
          'seebreeze': false,
          'seastorm': false,
          'flamie': false,
          'flabie': false,
          'feliphys': false,
          'mindlion': false,
          'dracotide': false,
          'dracoflow': false,
          'frostbite': false,
          'frostitoes': false,
          'minei': false,
          'minerax': false,
          'fluffernut': false,
          'razorleaf': false,
          'spork': false,
          'sporkle': false,
          'zazzle': false,
          'chiliwrath': false,
          'chiliclaw': false,
          'doldog': false,
          'roseburst': false,
          'flowerburst': false,
          'frostie': false,
          'froster': false,
          'dolie': false,
          'dolphie': false,
          'fenr': false,
          'fenrago': false,
          'mindwave': false,
          'psywave': false,
          'boolder': false,
          'boolderback': false,
          'aquazoid': false,
          'thunderstrike': false,
          'bippitibop': false,
          'venomous': false,
          'psycodactyl': false,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
        final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        final userCandy = userDoc['candy'];
        final userEnergy = userDoc['energy'];
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: {'candy': userCandy, 'energy': userEnergy},
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _onGoogleSignInCancel() {
    print('Google ile giriş iptal edildi.');
  }


  Future<void> _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      UserCredential userCredential;
      final email = _emailController.text;
      final password = _passwordController.text;
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'candy': _candy,
        'energy': _energy,
        'email': email,
        'florass': false,
        'sparkie': false,
        'sparken': false,
        'aquadra': false,
        'shockwing': false,
        'zapwing': false,
        'joltur': false,
        'joltrik': false,
        'mysticon': false,
        'psypup': false,
        'psydog': false,
        'dolphineon': false,
        'rockslide': false,
        'rockfist': false,
        'silentpaw': false,
        'shadowclaw': false,
        'electromon': false,
        'eaglestorm': false,
        'skywing': false,
        'woolie': false,
        'wooliec': false,
        'wooliectra': false,
        'spookums': false,
        'spookram': false,
        'nimowl': false,
        'wisowl': false,
        'fliefox': false,
        'fluffox': false,
        'drogie': false,
        'drogice': false,
        'drogrost': false,
        'monrass': false,
        'gorrass': false,
        'flamerock': false,
        'flameburst': false,
        'vaseblade': false,
        'leafblade': false,
        'forestblade': false,
        'glimmer': false,
        'schimmer': false,
        'dunebelle': false,
        'infernus': false,
        'blazenus': false,
        'whispurr': false,
        'ghosteroid': false,
        'toxibug': false,
        'toxiban': false,
        'citrusclaw': false,
        'gingerpaw': false,
        'poliba': false,
        'skov': false,
        'skovie': false,
        'rhinohorn': false,
        'rhinorock': false,
        'seebreeze': false,
        'seastorm': false,
        'flamie': false,
        'flabie': false,
        'feliphys': false,
        'mindlion': false,
        'dracotide': false,
        'dracoflow': false,
        'frostbite': false,
        'frostitoes': false,
        'minei': false,
        'minerax': false,
        'fluffernut': false,
        'razorleaf': false,
        'spork': false,
        'sporkle': false,
        'zazzle': false,
        'chiliwrath': false,
        'chiliclaw': false,
        'doldog': false,
        'roseburst': false,
        'flowerburst': false,
        'frostie': false,
        'froster': false,
        'dolie': false,
        'dolphie': false,
        'fenr': false,
        'fenrago': false,
        'mindwave': false,
        'psywave': false,
        'boolder': false,
        'boolderback': false,
        'aquazoid': false,
        'thunderstrike': false,
        'bippitibop': false,
        'venomous': false,
        'psycodactyl': false,
      });
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> _login() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final candy = userDoc['candy'];
      final energy = userDoc['energy'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePage(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0,-0.9),
              child: Image.asset('assets/logo1.png', width: 300,height: 300,),
            ),
            Align(
              alignment: Alignment(0,0.7),
              child: Container(
                color: Colors.cyan,
                width: 300,
                height: 320,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: 'mail'.tr,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.mail),
                              filled: true,
                              fillColor: Colors.white
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (!value.contains('@')) {
                              return 'validMail'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: 'password'.tr,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'passwordLength'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('email1'.tr),
                          ),
                        );
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.question_mark, size: 20,),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[400]
                          ),
                          onPressed: _login,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('login'.tr),
                              SizedBox(width: 5,),
                              Icon(Icons.login),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[400]
                          ),
                          onPressed: _submitForm,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('register'.tr),
                              SizedBox(width: 5,),
                              Icon(Icons.person_add)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[400]
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Sign in with Google'),
                              SizedBox(width: 5,),
                              Image.asset('assets/google1.png', width: 20,height: 20,),
                            ],
                          ),
                          onPressed:  () => _signInWithGoogle(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}
