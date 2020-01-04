Cypress.Commands.add('select', (id) => cy.get(`[data-test="${id}"]`))
Cypress.Commands.add('selectInput', (id) => cy.get(`[data-test="${id}"] > input`))

Cypress.Commands.add('clickNav', (name) => {
  cy.contains('nav a', name).click()
})

Cypress.Commands.add('acceptConfirm', () => {
  cy.get('#noty-confirm .noty_buttons button:first-child').click()
})

Cypress.Commands.add('cancelConfirm', () => {
  cy.get('#noty-confirm .noty_buttons button:last-child').click()
})

Cypress.Commands.add('alert', (message) => {
  cy.get('.noty_type__error .noty_body', { timeout: 10000 }).then(($noty) => {
    expect($noty).to.contain(message)
  })
})

Cypress.Commands.add('success', (message) => {
  cy.get('.noty_type__success .noty_body', { timeout: 10000 }).then(($noty) => {
    expect($noty).to.contain(message)
  })
})

Cypress.Commands.add('addToHangar', (ship) => {
  cy.get(`.model-panel#${ship} [data-test="add-to-hangar"]`).click()
})

Cypress.Commands.add('openShipModal', (ship) => {
  cy.get(`.model-panel#${ship} [data-test="vehicle_edit"]`).click()
})

Cypress.Commands.add('deleteShip', () => {
  cy.select('vehicle-delete').click()
})

Cypress.Commands.add('login', () => {
  cy.url().should('include', '/login')

  cy.wait(500)

  // eslint-disable-next-line jest/valid-expect-in-promise
  cy.fixture('users').then((userData) => {
    cy.select('login').type(userData.test.username)
    cy.select('password').type(userData.test.password)

    cy.get('button[type=submit]').click()

    cy.contains('.username', userData.test.username).should('exist')
  })
})
