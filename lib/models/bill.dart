import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final String amount;
  final String actualAmount;
  final String currency;
  final String number;
  final String owner;
  final String type;
  final String percentBill;
  final double percent;
  final int month;
  final bool isOpen;

  Bill(
      {this.amount,
      this.actualAmount,
      this.currency,
      this.number,
      this.owner,
      this.type,
      this.percent,
      this.percentBill,
      this.isOpen,
      this.month});

  factory Bill.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) {
      return null;
    }
    return Bill(
      amount: snapshot['amount'],
      actualAmount: snapshot['actualAmount'],
      currency: snapshot['currency'],
      number: snapshot['number'],
      owner: snapshot['owner'],
      type: snapshot['type'],
      percent: snapshot['percent'],
      percentBill: snapshot['percentBill'],
      isOpen: snapshot['isOpen'],
      month: snapshot['month'],
    );
  }
}
