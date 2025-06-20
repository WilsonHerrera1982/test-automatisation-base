Feature: Consultas de personajes de Marvel
  Escenarios para GET personajes

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'

  Scenario: Obtener todos los personajes
    Given path username, 'api', 'characters'
    When method GET
    Then status 200
    # * match response == []
    # * match response == '#[]'  # Lista vacía o con elementos
    And print response

  Scenario: Obtener personaje por ID exitoso
    # Primero creamos un personaje
    * def tempName = 'HeroeConsulta_' + java.util.UUID.randomUUID().toString()
    Given path username, 'api', 'characters'
    And request { name: '#(tempName)', alterego: 'AlteregoConsulta', description: 'Consulta', powers: ['Consulta'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def idConsultado = response.id
    And print response
    # Ahora lo consultamos
    Given path username, 'api', 'characters', idConsultado
    When method GET
    Then status 200
    # * match response.id == idConsultado
    # * match response.name == tempName
    And print response

  Scenario: Obtener personaje por ID no existe
    Given path username, 'api', 'characters', 9999
    When method GET
    Then status 404
    # * match response.error == 'Character not found'
    And print response
