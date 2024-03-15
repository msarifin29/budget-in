import 'package:budget_in/core/core.dart';
import 'package:budget_in/injection.dart';
import 'package:intl/intl.dart';

final spf = sl<SharedPreferencesManager>();

class Helpers {
  static const success = 'success';
  static String getErrorMessageFromEndpoint(
      dynamic dynamicErrorMessage, String httpErrorMessage, int statusCode) {
    if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('reason') &&
        dynamicErrorMessage['reason'].isNotEmpty) {
      return 'status code : $statusCode || error: ${dynamicErrorMessage['reason']}';
    } else if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('message') &&
        dynamicErrorMessage['message'].isNotEmpty) {
      return 'status code : $statusCode || error: ${dynamicErrorMessage['message']}';
    } else if (dynamicErrorMessage is String) {
      return httpErrorMessage;
    } else {
      return httpErrorMessage;
    }
  }

  static String getUid() {
    return spf.getString(SharedPreferencesManager.keyUid) ?? '';
  }

  static String getAccountId() {
    return spf.getString(SharedPreferencesManager.keyAccountId) ?? '';
  }

  static String replaceString(String v) {
    return v.replaceAll(RegExp('.'), "*");
  }

  static String currency(num n) {
    return NumberFormat.currency(locale: 'ID', symbol: '', decimalDigits: 0)
        .format(n);
  }
}

class ConstantType {
  static const cash = 'Cash';
  static const debit = 'Debit';
  static const credit = 'Credit';
  static String newConstantType(int v) {
    if (v == 1) {
      return cash;
    } else if (v == 2) {
      return debit;
    } else {
      return debit;
    }
  }
}

class CategoryExpense {
  static const other = 'other';
  static const foodAndDrink = 'food and drink';
  static const shopping = 'shopping';
  static const transport = 'transport';
  static const motorCycleOrCar = 'motorcycle or car';
  static const traveling = 'traveling';
  static const healty = 'healty';
  static const costAndBill = 'cost and bill';
  static const education = 'education';
  static const sportAndHobby = 'sport and hobby';
  static const beauty = 'beauty';
  static const work = 'work';
  static const foodIngredients = 'food ingredients';
  static String newCategoryExpense(int id) {
    switch (id) {
      case 1:
        return other;
      case 2:
        return foodAndDrink;
      case 3:
        return shopping;
      case 4:
        return transport;
      case 5:
        return motorCycleOrCar;
      case 6:
        return traveling;
      case 7:
        return healty;
      case 8:
        return costAndBill;
      case 9:
        return education;
      case 10:
        return sportAndHobby;
      case 11:
        return beauty;
      case 12:
        return work;
      case 13:
        return foodIngredients;
      default:
        return 'other';
    }
  }
}

class CategoryIncome {
  static const other = 'other';
  static const business = 'business';
  static const salary = 'salary';
  static const additionalIncome = 'additional income';
  static const loan = 'loan';
  static String newCategoryIncome(int id) {
    switch (id) {
      case 1:
        return other;
      case 2:
        return business;
      case 3:
        return salary;
      case 4:
        return additionalIncome;
      case 5:
        return loan;
      default:
        return other;
    }
  }
}

class CategoryCredit {
  static const other = 'other'; //id 1
  static const electronic = "electronic"; // id 2
  static const handphone = "handphone"; // id 3
  static const computerAndLaptop = "computer and laptop"; // id 4
  static const motorcycle = "motorcycle"; // id 5
  static const car = "car"; // id 6
  static const property = "property"; // id 7
  static const furniture = "furniture"; // id 8
  static const kitchenSet = "kitchen set"; // id 9
  static const ventureCapital = "venture capital"; // id 10
  static String newCategoryIncome(int id) {
    switch (id) {
      case 1:
        return other;
      case 2:
        return electronic;
      case 3:
        return handphone;
      case 4:
        return computerAndLaptop;
      case 5:
        return motorcycle;
      case 6:
        return car;
      case 7:
        return property;
      case 8:
        return furniture;
      case 9:
        return kitchenSet;
      case 10:
        return ventureCapital;
      default:
        return other;
    }
  }
}
