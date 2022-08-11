import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  TextEditingController textController = TextEditingController();

  String encryptedString = "";
  String _dropDownValue = "MD5";

  void encrypt() {
    var bytes = utf8.encode(textController.text);
    var digest = Digest(bytes);
    switch (_dropDownValue) {
      case "MD5":
        digest = md5.convert(bytes);
        break;
      case "SHA-1":
        digest = sha1.convert(bytes);
        break;
      case "SHA-224":
        digest = sha224.convert(bytes);
        break;
      case "SHA-256":
        digest = sha256.convert(bytes);
        break;
      case "SHA-384":
        digest = sha384.convert(bytes);
        break;
      case "SHA-512":
        digest = sha512.convert(bytes);
        break;
      case "SHA-512/256":
        digest = sha512256.convert(bytes);
        break;
      case "SHA-512/224":
        digest = sha512224.convert(bytes);
        break;
      default:
        digest = md5.convert(bytes);
        break;
    }
    setState(() {
      encryptedString = digest.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Crypto"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(controller: textController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                      hint: Text(
                        _dropDownValue,
                        style: TextStyle(color: Colors.blue),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: [
                        "MD5",
                        "SHA-1",
                        "SHA-224",
                        "SHA-256",
                        "SHA-384",
                        "SHA-512",
                        "SHA-512/256",
                        "SHA-512/256",
                      ].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: encrypt, child: const Text("Encrypt")),
                ],
              ),
              const SizedBox(height: 50),
              Text(encryptedString),
            ],
          ),
        ),
      ),
    );
  }
}
