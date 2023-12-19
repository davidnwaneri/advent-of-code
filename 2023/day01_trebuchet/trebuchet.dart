void main() {
  const calibrationDocument = <String>[]; // Replace with yours
  final calibrationValues = calibrationDocument.map((e) => findCalibrationValue(e));
  final result = calibrationValues.fold(
    0,
    (previousValue, element) => previousValue + element.twoDigits,
  );
  print('Result: $result');
}

CalibrationValue findCalibrationValue(String text) {
  final firstValue = findFirstValue(text);
  final secondValue = findSecondValue(text);

  return CalibrationValue(first: firstValue, second: secondValue);
}

int findFirstValue(String text) {
  int? firstValue;
  final characters = text.split('').iterator;

  String previousCharacters = '';
  while (characters.moveNext()) {
    final currentCharacter = characters.current;
    final previousCharactersPlusCurrent = previousCharacters + currentCharacter;

    final foundFirstValueAsDigit = int.tryParse(currentCharacter) != null;

    if (foundFirstValueAsDigit) {
      firstValue = int.parse(currentCharacter);
      break;
    }

    final firstValueAsWord = getDigitInWord(previousCharactersPlusCurrent);
    if (firstValueAsWord != null) {
      firstValue = getDigit(firstValueAsWord)!;
      break;
    }
    previousCharacters = previousCharactersPlusCurrent;
  }

  return firstValue!;
}

int findSecondValue(String text) {
  int? secondValue;
  final characters = text.split('');

  String previousCharacters = '';
  for (int i = characters.length - 1; i >= 0; i--) {
    final currentCharacter = characters[i];
    final previousCharactersPlusCurrent = currentCharacter + previousCharacters;

    final foundSecondValueAsDigit = int.tryParse(currentCharacter) != null;
    if (foundSecondValueAsDigit) {
      secondValue = int.parse(currentCharacter);
      break;
    }

    final secondValueAsWord = getDigitInWord(previousCharactersPlusCurrent);
    if (secondValueAsWord != null) {
      secondValue = getDigit(secondValueAsWord)!;
      break;
    }

    previousCharacters = previousCharactersPlusCurrent;
  }
  return secondValue!;
}

final wordToDigitsMap = <String, int>{
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
};

int? getDigit(String text) {
  final value = wordToDigitsMap.keys.firstWhere(
    (e) => text.contains(e),
    orElse: () => '',
  );

  return wordToDigitsMap[value];
}

String? getDigitInWord(String text) {
  final value = wordToDigitsMap.keys.firstWhere(
    (e) => text.contains(e),
    orElse: () => '',
  );

  return value.isEmpty ? null : value;
}

class CalibrationValue {
  CalibrationValue({
    required this.first,
    required this.second,
  });

  int first;
  int second;

  int get twoDigits => int.parse('$first$second');
}
