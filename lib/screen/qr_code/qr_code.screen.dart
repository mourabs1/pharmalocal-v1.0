import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  String qrCodeResult = "Ainda não scanneado";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image(
                    image: NetworkImage(
                        "https://media.istockphoto.com/vectors/qr-code-scan-phone-icon-in-comic-style-scanner-in-smartphone-vector-vector-id1166145556")),
                _flatButton("Scan QR CODE"),
                Center(child: Text('$qrCodeResult'))
              ],
            ),
          );
        }));
  }

  _flatButton(String text) {
    return TextButton(
      onPressed: () => scanQRCode(),
      child: Text(
        "Bipar QR Code",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> scanQRCode() async {
    String barcodeScan;
    try {
      barcodeScan = await FlutterBarcodeScanner.scanBarcode(
          '#FFFFFF', 'Cancel', true, ScanMode.QR);
      print(barcodeScan);
    } on PlatformException {
      barcodeScan = 'Falha na versão da aplicação';
    }
    if (!mounted) return;
    setState(() {
      qrCodeResult = barcodeScan;
    });
  }
}
