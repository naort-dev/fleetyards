describe("Ship", () => {
  it("Loads", () => {
    cy.visitApp("/ships");

    cy.acceptCookies();

    cy.waitForPageToLoad();

    cy.get(".panel-title a span").contains("100i");

    cy.get(".model-panel#100i .panel-title a span").click();

    cy.url().should("include", "/ships/100i");

    cy.get("h1").should(($h1) => {
      expect($h1).to.contain("100i");
    });

    cy.selectElement("model-dropdown").click();
    cy.selectElement("compare").click();

    cy.url().should("include", "/compare/ships/?models%5B%5D=100i");
  });
});
