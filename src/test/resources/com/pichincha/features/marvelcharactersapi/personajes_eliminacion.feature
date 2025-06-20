Feature: Eliminación de personajes de Marvel
  Escenarios para DELETE personajes

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'
    * def tempName = 'HeroeAEliminar_' + java.util.UUID.randomUUID().toString()

  Scenario: Eliminar personaje exitoso
    # Primero creamos un personaje para eliminar
    Given path username, 'api', 'characters'
    And request { name: '#(tempName)', alterego: 'ParaEliminar', description: 'Eliminar', powers: ['Borrar'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def idAEliminar = response.id
    And print response
    # Ahora lo eliminamos
    Given path username, 'api', 'characters', idAEliminar
    When method DELETE
    Then status 204
    And print response

  Scenario: Eliminar personaje no existe
    Given path username, 'api', 'characters', 9999
    When method DELETE
    Then status 404
    # * match response.error == 'Character not found'
    And print response
