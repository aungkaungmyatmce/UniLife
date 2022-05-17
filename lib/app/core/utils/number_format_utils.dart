import 'dart:math';
import 'package:intl/intl.dart';

class NumberFormatUtils {
  static const thousandSeparatorFormat = '#,###,##0';

  static String convertThousandSeparatorFormat(double amount) {
    var formatter = NumberFormat(thousandSeparatorFormat);
    return formatter.format(amount);
  }

  static double roundOffToXDecimal(double number, {int numberOfDecimal = 3}) {
    String numbersAfterDecimal = number.toString().split('.')[1];
    if (numbersAfterDecimal != '0') {
      int existingNumberOfDecimal = numbersAfterDecimal.length;
      number += 1 / (10 * pow(10, existingNumberOfDecimal));
    }

    return double.parse(number.toStringAsFixed(numberOfDecimal));
  }

  static calculateAmountFromPercent(double totalPrice, double percent) {
    return percent / 100 * totalPrice;
  }

  static calculatePercentFromAmount(double totalPrice, double amount) {
    return (amount / totalPrice) * 100;
  }
}
