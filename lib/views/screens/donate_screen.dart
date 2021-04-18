import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:soshare/views/screens/home_screen.dart';

void main() => runApp(DonatePage());

class DonatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DonatePageState();
  }
}

class DonatePageState extends State<DonatePage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Odeme Ekranı'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children:[
                creditCardUi(),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      formField(),
                      miktarFormField(),
                      submitButton(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CreditCardWidget creditCardUi() {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: true,
      obscureCardCvv: true,
    );
  }

  CreditCardForm formField() {
    return CreditCardForm(
      formKey: formKey,
      obscureCvv: true,
      obscureNumber: true,
      cardNumber: cardNumber,
      cvvCode: cvvCode,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      themeColor: Colors.red,
      cardNumberDecoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Kart Numarası',
        hintText: 'XXXX XXXX XXXX XXXX',
      ),
      expiryDateDecoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Son kullanma tarihi',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Isım Soyisim',
      ),
      onCreditCardModelChange: onCreditCardModelChange,
    );
  }

  Container miktarFormField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Miktar',
        ),
      ),
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          print('valid!');
        } else {
          print('invalid!');
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Container(height: 50, child: Text('Bagisiniz alınmıştır'))));
        Get.off(HomeScreen());
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: Color(0xff1b447b),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Text(
          'Gönder',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'halter',
            fontSize: 14,
            package: 'flutter_credit_card',
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
