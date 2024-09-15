/// This is the main function that calculates the shipping cost based on the destination zone and weight in kilograms.
///
/// The function takes no arguments and returns no values.
/// It initializes a variable `destZone` with the destination zone as a string and `weightInKgs` with the weight in kilograms as a double.
/// It then checks the value of `destZone` using if-else statements and prints the corresponding shipping information.
/// If `destZone` is equal to 'ABC', it prints 'Shipping to ABC zone' and the shipping cost calculated by multiplying `weightInKgs` by 10.
/// If `destZone` is equal to 'PQR', it prints 'Shipping to PQR zone' and the shipping cost calculated by multiplying `weightInKgs` by 20.
/// If `destZone` is equal to 'XYZ', it prints 'Shipping to XYZ zone' and the shipping cost calculated by multiplying `weightInKgs` by 30.
/// If `destZone` does not match any of the specified zones, it prints 'Invalid zone'.
void main() {
  String destZone = 'PQR';
  double weightInKgs = 6;

  if(destZone == 'ABC') {
    print('Shipping to ABC zone');
    print('Shipping cost: \$${weightInKgs * 10}');
  } else if(destZone == 'PQR') {
    print('Shipping to PQR zone');
    print('Shipping cost: \$${weightInKgs * 20}');
  } else if(destZone == 'XYZ') {
    print('Shipping to XYZ zone');
    print('Shipping cost: \$${weightInKgs * 30}');
  } else {
    print('Invalid zone');
  }
}
