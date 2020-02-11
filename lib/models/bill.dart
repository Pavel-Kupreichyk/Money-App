import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final double amount;
  final double actualAmount;
  final String currency;
  final String number;
  final String owner;
  final String type;
  final PercentBill percentBill;
  final int month;
  final bool isOpen;

  Bill(
      {this.amount,
      this.actualAmount,
      this.currency,
      this.number,
      this.owner,
      this.type,
      this.percentBill,
      this.isOpen,
      this.month});

  factory Bill.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) {
      return null;
    }
    return Bill(
      amount: snapshot['amount'].toDouble(),
      actualAmount: snapshot['actualAmount'].toDouble(),
      currency: snapshot['currency'],
      number: snapshot['number'],
      owner: snapshot['owner'],
      type: snapshot['type'],
      percentBill: snapshot['percentBill'] != null
          ? PercentBill(
              amount: snapshot['percentBill']['amount'].toDouble(),
              number: snapshot['percentBill']['number'],
              percent: snapshot['percentBill']['percent'].toDouble())
          : null,
      isOpen: snapshot['isOpen'],
      month: snapshot['month'],
    );
  }
}

class PercentBill {
  final double amount;
  final String number;
  final double percent;
  PercentBill({this.amount, this.number, this.percent});
}
