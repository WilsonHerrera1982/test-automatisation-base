Feature: Obtener todos los personajes de Marvel
  Este feature valida el endpoint para listar todos los personajes de la API de Marvel.

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'
    * path username, 'api', 'characters'

  Scenario: Obtener todos los personajes exitosamente
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method GET
    Then status 200
    # * match response == []
    # * match response == '#[]'  # Valida que la respuesta sea una lista vacía
    # Puedes descomentar y ajustar los matchers según los datos esperados
    And print response
