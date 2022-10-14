bool selectedMin = false;
bool selectedMed = false;
bool selectedMax = false;
bool differentChoice = false;
int donationAmount = 0;
Map<String, dynamic> results = {};

getAmount(int amount, bool userInput, Map<String, dynamic> previous) {
  if (userInput == false && amount == previous['donationAmount']) {
    return;
  } else {
    switch (amount) {
      case 5:
        selectedMin = true;
        donationAmount = 5;
        break;
      case 10:
        selectedMed = true;
        donationAmount = 10;
        break;
      case 15:
        selectedMax = true;
        donationAmount = 15;
        break;
    }
  }
  // Alex: bad practice to use strings -- shuld prolly be a class
  results = {
    "selectedMin": selectedMin,
    "selectedMed": selectedMed,
    "selectedMax": selectedMax,
    "donationAmount": donationAmount
  };
  return results;
}
