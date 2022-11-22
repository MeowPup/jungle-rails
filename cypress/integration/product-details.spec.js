describe('home.spec.js', () => {
  beforeEach(() => {
  cy.visit('/');
  })

  it('should bring you to the product details page', () => {
    cy.get("article").first().click()
    cy.url().should('include', '/products/2')
  });

});