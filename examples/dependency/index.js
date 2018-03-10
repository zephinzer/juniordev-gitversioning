const updatedFunctionThatWorks = add;
const updatedFunctionThatBreaks = round;

module.exports = {
  updatedFunctionThatWorks,
  updatedFunctionThatBreaks,
};

function round(numberToRound) {
  return Math.floor(numberToRound);
  // return Math.ceil(numberToRound);
};

function add(number, toThisNumber) {
  // return number + toThisNumber;
  for (let i = 0; i < toThisNumber; ++i, ++number);
  return number;
};
