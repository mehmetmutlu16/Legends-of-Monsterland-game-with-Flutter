import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/themeSettings.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'changePage.dart';

class shopPage extends StatefulWidget {
  const shopPage({Key? key}) : super(key: key);

  @override
  State<shopPage> createState() => _shopPageState();
}

class _shopPageState extends State<shopPage> with WidgetsBindingObserver{

  List<String> _productIds = ['25energy'];

  ProductDetails? productDetails;
  ProductDetails? productDetails2;

  void _initInAppPurchase() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (isAvailable) {
      final Set<String> productIds = {'25energy'}; // doğru ürün tanımlayıcısını buraya ekleyin
      final ProductDetailsResponse productDetailsResponse = await InAppPurchase.instance.queryProductDetails(productIds);
      if (productDetailsResponse.notFoundIDs.isNotEmpty) {
        print('Product not found');
        return; // metodu sonlandırın
      }
      final List<ProductDetails> products = productDetailsResponse.productDetails;
      products.forEach((product) {
        if (product.id == '25energy') {
          productDetails = product;
        }
      });
      final Stream purchaseUpdates = InAppPurchase.instance.purchaseStream;
      purchaseUpdates.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
      purchaseUpdates.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated2(purchaseDetailsList);
      });
    }
  }

  void _initInAppPurchase2() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (isAvailable) {
      final Set<String> productIds = {'candy25'}; // doğru ürün tanımlayıcısını buraya ekleyin
      final ProductDetailsResponse productDetailsResponse = await InAppPurchase.instance.queryProductDetails(productIds);
      if (productDetailsResponse.notFoundIDs.isNotEmpty) {
        print('Product not found');
        return; // metodu sonlandırın
      }
      final List<ProductDetails> products = productDetailsResponse.productDetails;
      products.forEach((product) {
        if (product.id == 'candy25') {
          productDetails2 = product;
        }
      });
      final Stream purchaseUpdates = InAppPurchase.instance.purchaseStream;
      purchaseUpdates.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        final bool isValid = await _verifyPurchase(purchaseDetails);
        if (isValid) {
          incrementsEnergy2();
        } else {
          showFailedBuy();
        }
      }
    });
  }

  void _listenToPurchaseUpdated2(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        final bool isValid = await _verifyPurchase(purchaseDetails);
        if (isValid) {
        } else {
          showFailedBuy();
        }
      }
    });
  }

  Future<void> _buyProduct() async {
    if (productDetails != null) {
      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails!);
      await InAppPurchase.instance.buyNonConsumable(
          purchaseParam: purchaseParam);
    } else {
      print('Product not found');
    }
  }

  Future<void> _buyProduct2() async {
    if (productDetails2 != null) {
      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails2!);
      await InAppPurchase.instance.buyNonConsumable(
          purchaseParam: purchaseParam);
    } else {
      print('Product not found');
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // Satın alma işlemini doğrulayın. Satın alma işlemi doğrulama işlemi başarılı ise, true değeri döndürün.
    // Eğer satın alma işlemi geçersiz ise, false değeri döndürün.
    return true;
  }


  late int energy;
  late int candy;

  void incrementsCandy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newCandy = candy + 1;
    if (newCandy >= 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'candy': newCandy});

      setState(() {
        candy = newCandy;
      });
    }
  }

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      energy= data['energy'];
      candy = data['candy'];
    });
  }

  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = 'ca-app-pub-4225767728354504/1909713931';

  void _loadRewardedAd(){
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad){
          print('$ad loaded');
          rewardedAd = ad;
          _setFullScreenContentCallback();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad, Error: $error');
        },
      ),
    );
  }

  void _setFullScreenContentCallback(){
    if(rewardedAd==null) return;
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => print("$ad onShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("$ad onAdDismissedFullScreenContent");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
        print("$ad onAdFailedToShowFullScreenContent: $error");
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print("$ad Impression occured"),

    );
  }

  void _showRewardedAd(int sayi){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        for(int i=0;i<sayi;i++){
          incrementsCandy();
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => changePage()),
              (route) => false,
        );
      },
    );
  }

  void _showRewardedAdEnergy(int sayi){
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        for(int i=0;i<sayi;i++){
          incrementsEnergy();
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => changePage()),
              (route) => false,
        );
      },
    );
  }

  void incrementsEnergy() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newEnergy = energy + 1;
    if (newEnergy >= 0) {
      if(energy>20){
        energy=20;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'energy': newEnergy});
      }


      setState(() {
        energy = newEnergy;
      });
    }
  }

  void incrementsEnergy2() async {
    var user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var newEnergy = energy + 20;
    if (newEnergy >= 0) {
      if(energy>20){
        energy=20;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'energy': newEnergy});
      }


      setState(() {
        energy = newEnergy;
      });
    }
  }

  bool isPlaying = false;

  final player = AudioPlayer();

  @override
  void initState() {
    _initInAppPurchase();
    _initInAppPurchase2();
    loadData();
    _loadRewardedAd();
    WidgetsBinding.instance.addObserver(this);
    player.play(AssetSource('sounds/background2.mp3'));
    player.setReleaseMode(ReleaseMode.loop);
    isPlaying = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
      isPlaying = false;
    } else if (state == AppLifecycleState.resumed) {
      if (!isPlaying) {
        player.resume();
        isPlaying = true;
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal[100],
        title: Text("seeyousoon".tr),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("okay".tr),
          ),
        ],
      ),
    );
  }

  showFailedBuy() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal[100],
        title: Text("failedbuy".tr),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("okay".tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop', style: baslikStili,),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showRewardedAd(1);
                    },
                    child: Container(
                      width: 120,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/video1.png'),
                          ),
                          Text('watchAds'.tr, style: aciklamaStili,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/starIcon.png', width: 30,height: 30,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _showRewardedAdEnergy(5);
                    },
                    child: Container(
                      width: 120,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/video1.png'),
                          ),
                          Text('watchAds'.tr, style: aciklamaStili,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('5', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/energyIcon.png', width: 30,height: 30,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _buyProduct();
                    },
                    child: Container(
                      width: 120,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/energyIcon3.png'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('25', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/energyIcon.png', width: 30, height: 30,),
                              Text('= 1\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _buyProduct2();
                    },
                    child: Container(
                      width: 120,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/starIcon.png'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('25', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/starIcon.png', width: 30,height: 30,),
                              Text('= 1\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: showResult,
                    child: Container(
                      width: 140,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/starIcon2.png'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('200', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/starIcon.png', width: 30, height: 30,),
                              Text('= 5\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: showResult,
                    child: Container(
                      width: 140,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Image.asset('assets/shopPage/starIcon3.png'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('500', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Image.asset('assets/shopPage/starIcon.png', width: 30,height: 30,),
                              Text('= 10\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
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
