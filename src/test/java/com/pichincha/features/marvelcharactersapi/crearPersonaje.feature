Feature: Crear personaje de Marvel
  Este feature valida la creación de personajes y el manejo de errores por nombre duplicado.

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'
    * def basePath = [username, 'api', 'characters']

  Scenario: Crear personaje exitosamente
    Given path basePath
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Genius billionaire', powers: ['Armor', 'Flight'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    # * match response.name == 'Iron Man'
    # * match response.id == '#number'
    And print response

  Scenario: Crear personaje con nombre duplicado
    Given path basePath
    And request { name: 'Iron Man', alterego: 'Otro', description: 'Otro', powers: ['Armor'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 400
    # * match response.error == 'Character name already exists'
    And print response
