describe('add_to_cart.spec.js', () => {
  beforeEach(() => {
  cy.visit('/');
  });

  it('should allow users to add to cart and increase cart count', () => {
    cy.get(".btn").first().click({force: true})
    cy.contains("My Cart").should("contain", 1)
  });

});