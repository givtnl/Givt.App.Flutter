bool selectedMin = true;
bool selectedMed = false;
bool selectedMax = false;
bool differentChoice = false;
int donationAmount = 0;
Map<String, dynamic> results = {};

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
