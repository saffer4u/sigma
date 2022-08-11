import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DartIpifyPage extends StatefulWidget {
  const DartIpifyPage({Key? key}) : super(key: key);

  @override
  State<DartIpifyPage> createState() => _DartIpifyPageState();
}

class _DartIpifyPageState extends State<DartIpifyPage> {
  TextEditingController ipController = TextEditingController();
  String ipv4 = "";
  String ipv6 = "";
  String location = "";
  String locationByIp = "";
  void getDeviceIp() async {
    ipv4 = await Ipify.ipv4();
    ipv6 = await Ipify.ipv64();
    getGeoLocation();
    setState(() {});
  }

  void getGeoLocation() async {
    final response = await Ipify.geo("at_arKkIiEDKJZenDCUJk7aFcoNIfnaX");
    setState(() {
      location = response.location.toString();
    });
  }

  void getLocationByIp()async {
     final response = await Ipify.geo("at_arKkIiEDKJZenDCUJk7aFcoNIfnaX",ip: ipController.text);
     
    setState(() {
      locationByIp = response.location.toString();
    });
  }

  @override
  void initState() {
    getDeviceIp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dart Ipify"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your device IPV4 : \n$ipv4"),
            const SizedBox(height: 50),
            Text("Your device IPV6 : \n$ipv6"),
            const SizedBox(height: 50),
            Text("Your location by IP : \n$location"),
            const SizedBox(height: 50),
            const Text("Get location by IP"),
            TextFormField(
              controller: ipController,
            ),
            ElevatedButton(
              onPressed: getLocationByIp,
              child: const Text("Get Location"),
            ),
            const SizedBox(height: 50),
            Text(locationByIp),
          ],
        ),
      ),
    );
  }
}
