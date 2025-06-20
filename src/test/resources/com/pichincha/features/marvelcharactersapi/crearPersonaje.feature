Feature: Crear personaje de Marvel
  Este feature valida la creación de personajes y el manejo de errores por nombre duplicado.

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'

  Scenario: Crear personaje exitosamente
    * def uniqueName = 'IronMan_' + java.util.UUID.randomUUID().toString()
    Given path username, 'api', 'characters'
    And request { name: '#(uniqueName)', alterego: 'Tony Stark', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    # * match response.name == uniqueName
    # * match response.id == '#number'
    And print response

  Scenario: Crear personaje con nombre duplicado
    Given path username, 'api', 'characters'
    And request { name: 'Iron Man', alterego: 'Otro', description: 'Otro', powers: ['Armor'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 400
    # * match response.error == 'Character name already exists'
    And print response
