test('there is no I in test', () => {
  expect('test').not.toMatch(/I/);
});