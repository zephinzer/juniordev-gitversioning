const dependency = require('juniordev-gitversioning-dependency');

describe('dependency', () => {
  describe('updatedFunctionThatWorks', () => {
    it('works as expected', () => {
      expect(dependency.updatedFunctionThatWorks(5, 3)).to.eql(8);
    });
  });

  describe('updatedFunctionThatBreaks', () => {
    it('works as expected', () => {
      expect(dependency.updatedFunctionThatBreaks(1.6)).to.eql(2);
    });
  });
});
