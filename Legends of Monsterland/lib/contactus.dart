import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/themeSettings.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {

  _launchInstagramURL() async {
    const url = 'https://instagram.com/legendsofmonsterland?igshid=ZDdkNTZiNTM=';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTwitterURL() async {
    const url = 'https://twitter.com/Monsterland_of?t=_6KqepW4yEfIDOQazuwh5g&s=08';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTelegramURL() async {
    const url = 'https://t.me/legendsofmonsterland';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchYoutubeURL() async {
    const url = 'https://youtube.com/@legendsofmonsterland';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchDiscordURL() async {
    const url = 'https://discord.gg/FZ2Dh9eM';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchFacebookURL() async {
    const url = 'https://www.facebook.com/groups/179453404838802/?ref=share&mibextid=KtfwRi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchRedditURL() async {
    const url = 'https://www.reddit.com/r/LegendsOfMonsterland?utm_medium=android_app&utm_source=share';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTiktokURL() async {
    const url = 'https://www.tiktok.com/@legendsofmonsterland?_t=8acHaQuooOz&_r=1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contactus'.tr, style: baslikStili,),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _launchTwitterURL,
              child: Text('TWITTER', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchInstagramURL,
              child: Text('INSTAGRAM', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchFacebookURL,
              child: Text('FACEBOOK', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchTelegramURL,
              child: Text('TELEGRAM', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchYoutubeURL,
              child: Text('YOUTUBE', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchDiscordURL,
              child: Text('DISCORD', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchRedditURL,
              child: Text('REDDIT', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            ElevatedButton(
              onPressed: _launchTiktokURL,
              child: Text('TIKTOK', style: icerikStili,),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
            ),
            SizedBox(height: 10,),
            Text('legendsofmonsterland@gmail.com', style: icerikStili,)
          ],
        ),
      ),
    );
  }
}
