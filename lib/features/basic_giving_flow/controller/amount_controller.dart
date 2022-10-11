bool selectedMin = true;
bool selectedMed = false;
bool selectedMax = false;
bool differentChoice = false;
int donationAmount = 0;
Map<String, dynamic> results = {};

getAmountOld(String selection, bool selectionState, int? amount) {
  if (selectionState == true) {
    print('some bullshit');
    selectedMin = false;
    selectedMed = false;
    selectedMax = false;
    donationAmount = 0;
  } else {
    switch (selection) {
      case "selectedMin":
        selectedMin = true;
        selectedMed = false;
        selectedMax = false;
        donationAmount = 5;
        break;
      case "selectedMed":
        selectedMin = false;
        selectedMed = true;
        selectedMax = false;
        donationAmount = 10;
        break;
      case "selectedMax":
        selectedMin = false;
        selectedMed = false;
        selectedMax = true;
        donationAmount = 15;
        break;
      case "other":
        selectedMin = false;
        selectedMed = false;
        selectedMax = false;
        donationAmount = amount!;
        break;
    }
  }
  results = {
    "selectedMin": selectedMin,
    "selectedMed": selectedMed,
    "selectedMax": selectedMax,
    "differentChoice": differentChoice,
    "donationAmount": donationAmount
  };
  return results;
}

setDifferentAmount(String input) {
  selectedMin = false;
  selectedMed = false;
  selectedMax = false;
  differentChoice = true;
  donationAmount = int.parse(input);
  results = {
    "selectedMin": selectedMin,
    "selectedMed": selectedMed,
    "selectedMax": selectedMax,
    "differentChoice": differentChoice,
    "donationAmount": donationAmount
  };
  return results;
}

getAmount(int amount, bool userInput, Map<String, dynamic> previous) {
  if (userInput == false && amount == previous['donationAmount']) {
    selectedMin = false;
    selectedMed = false;
    selectedMax = false;
    donationAmount = 0;
  } else {
    switch (amount) {
      case 5:
        selectedMin = true;
        selectedMed = false;
        selectedMax = false;
        donationAmount = 5;
        break;
      case 10:
        selectedMin = false;
        selectedMed = true;
        selectedMax = false;
        donationAmount = 10;
        break;
      case 15:
        selectedMin = false;
        selectedMed = false;
        selectedMax = true;
        donationAmount = 15;
        break;
      default:
        selectedMin = false;
        selectedMed = false;
        selectedMax = false;
        donationAmount = amount;
        break;
    }
  }
  results = {
    "selectedMin": selectedMin,
    "selectedMed": selectedMed,
    "selectedMax": selectedMax,
    "userInput": userInput,
    "donationAmount": donationAmount
  };
  return results;
}
