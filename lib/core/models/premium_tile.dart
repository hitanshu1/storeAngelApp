import 'package:storeangelApp/core/enums/premium_selected_tile.dart';

class PremiumTile {
  final String header;
  final String monthString;
  final String price;
  final PremiumSelectedTile tileName;
  final int stackPosition;
  final String paymentType;

  bool isSelected;
  bool wasLastSelected;

  PremiumTile(
      {this.header,
      this.monthString,
        this.paymentType,
      this.price,
      this.stackPosition,
      this.tileName,
      this.isSelected = false,
      this.wasLastSelected = false});

  @override
  String toString() {
    return 'header:$header,  monthString:$monthString, price:$price, premiumTile:$tileName, stackPosition:$stackPosition, wasLastSelected:$wasLastSelected';
  }

  @override
  bool operator ==(covariant PremiumTile other) {
    return this.header == other.header &&
        this.monthString == other.monthString &&
        this.price == other.price &&
        this.tileName == other.tileName &&
        this.stackPosition == other.stackPosition &&
        this.wasLastSelected == other.wasLastSelected;
  }

  @override
  int get hashCode => super.hashCode;
}
