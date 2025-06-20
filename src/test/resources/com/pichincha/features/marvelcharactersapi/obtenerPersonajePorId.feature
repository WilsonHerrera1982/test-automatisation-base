Feature: Obtener personaje por ID
  Este feature valida la obtención de un personaje específico por su ID y el manejo de errores cuando no existe.

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'

  Scenario: Obtener personaje por ID exitosamente
    Given path username, 'api', 'characters', 1
    When method GET
    Then status 200
    # * match response.id == 1
    # * match response.name == 'Iron Man'
    And print response

  Scenario: Obtener personaje por ID que no existe
    Given path username, 'api', 'characters', 999
    When method GET
    Then status 404
    # * match response.error == 'Character not found'
    And print response
