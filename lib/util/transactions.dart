import 'package:budget_app/constants/enums.dart';

TransactionType getType(String type) {
  switch (type) {
    case 'spent':
      return TransactionType.spent;
    case 'receive':
      return TransactionType.receive;
    default:
      return TransactionType.spent;
  }
}

TransactionCategory getCategory(String type) {
  switch (type) {
    case 'food':
      return TransactionCategory.food;
    case 'clothes':
      return TransactionCategory.clothes;
    case 'travel':
      return TransactionCategory.travel;
    case 'miscellaneous':
      return TransactionCategory.miscellaneous;
    default:
      return TransactionCategory.miscellaneous;
  }
}

String getCategoryString(TransactionCategory category) {
  switch (category) {
    case TransactionCategory.food:
      return 'Food';
    case TransactionCategory.clothes:
      return 'Clothes';
    case TransactionCategory.travel:
      return 'Travel';
    case TransactionCategory.miscellaneous:
      return 'Miscellaneous';
  }
}
