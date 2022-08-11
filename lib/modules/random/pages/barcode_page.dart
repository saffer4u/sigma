
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  TextEditingController textController = TextEditingController();

  String errorText = "";

  final barcodeTypes = [
    'QR-Code',
    'CODE 39',
    'CODE 93',
    'code-128a',
    'code-128b',
    'code-128c',
    'gs128',
    'itf14',
    'itf16',
    'ean13',
    'ean8',
    'ean2',
    'ean5',
    'isbn',
    'upcA',
    'upcE',
    'telepen',
    'codabar',
    'pdf417',
    'dataMatrix',
    'aztec',
    'rm4scc',
    'itf',
  ];

  Widget? barcode;
  String _dropDownValue = 'QR-Code';

  void buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();

    barcode = SvgPicture.string(svg);
  }

  void onChanged(String val) {
    val = textController.text;
    try {
      switch (_dropDownValue) {
        case 'QR-Code':
          buildBarcode(Barcode.qrCode(), val, height: 200);
          break;
        case 'CODE 39':
          buildBarcode(Barcode.code39(), val);
          break;
        case 'CODE 93':
          buildBarcode(Barcode.code93(), val);
          break;
        case 'code-128a':
          buildBarcode(
              Barcode.code128(useCode128B: false, useCode128C: false), val,
              filename: 'code-128a');
          break;
        case 'code-128b':
          buildBarcode(
              Barcode.code128(useCode128A: false, useCode128C: false), val,
              filename: 'code-128b');
          break;
        case 'code-128c':
          buildBarcode(
              Barcode.code128(useCode128A: false, useCode128B: false), val,
              filename: 'code-128c');
          break;
        case 'gs128':
          buildBarcode(Barcode.gs128(), val);
          break;

        case 'itf14':
          buildBarcode(Barcode.itf14(), val);
          break;
        case 'itf16':
          buildBarcode(Barcode.itf16(), val);
          break;

        case 'ean13':
          buildBarcode(Barcode.ean13(), val);
          break;
        case 'ean8':
          buildBarcode(Barcode.ean8(), val, width: 100);
          break;
        case 'ean2':
          buildBarcode(Barcode.ean2(), val, width: 40);
          break;
        case 'ean5':
          buildBarcode(Barcode.ean5(), val, width: 60);
          break;

        case 'isbn':
          buildBarcode(Barcode.isbn(), val);
          break;
        case 'upcA':
          buildBarcode(Barcode.upcA(), val);
          break;
        case 'upcE':
          buildBarcode(Barcode.upcE(), val, width: 100);
          break;

        case 'telepen':
          buildBarcode(Barcode.telepen(), val);
          break;

        case 'codabar':
          buildBarcode(Barcode.codabar(explicitStartStop: true), val);
          break;

        case 'pdf417':
          buildBarcode(Barcode.pdf417(), val, height: 30);
          break;
        case 'dataMatrix':
          buildBarcode(Barcode.dataMatrix(), val, height: 200);
          break;

        case 'aztec':
          buildBarcode(Barcode.aztec(), val, height: 200);
          break;

        case 'rm4scc':
          buildBarcode(Barcode.rm4scc(), val, height: 50, fontHeight: 30);
          break;

        case 'itf':
          buildBarcode(Barcode.itf(), val);
          break;

        default:
          buildBarcode(Barcode.qrCode(), val, height: 200);
          break;
      }
      errorText = "";
    } catch (e) {
      errorText = "Unsupported Text $e";
    }
    if (val.isEmpty) {
      barcode = null;
      errorText = "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barcode"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            barcode ?? const SizedBox.shrink(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
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
                      items: barcodeTypes.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        _dropDownValue = val.toString();

                        onChanged(val.toString());
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: "Enter Text to encode..."),
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
           const SizedBox(height: 30),
            Text(
              errorText,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
