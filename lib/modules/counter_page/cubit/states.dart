abstract class CounterStates {}

class initValue extends CounterStates {}

class minusValue extends CounterStates {
  int com;

  minusValue(this.com);
}

class plusValue extends CounterStates {
  int cop;

  plusValue(this.cop);
}
