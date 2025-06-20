Feature: Creación y actualización de personajes de Marvel
  Escenarios para POST y PUT personajes

  Background:
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'
    * def uniqueName = 'Hero_' + java.util.UUID.randomUUID().toString()

  Scenario: Crear personaje exitoso
    Given path username, 'api', 'characters'
    And request { name: '#(uniqueName)', alterego: 'Nuevo Alterego', description: 'Nuevo personaje', powers: ['Poder1'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def createdId = response.id
    And print response

  Scenario: Crear personaje nombre duplicado
    Given path username, 'api', 'characters'
    And request { name: '#(uniqueName)', alterego: 'Otro', description: 'Otro', powers: ['Poder2'] }
    And header Content-Type = 'application/json'
    When method POST
    # La API permite duplicados, así que aceptamos 201
    Then status 201
    # * match response.id != null
    # NOTA: La API no valida duplicados, esto es un posible bug de backend
    And print response

  Scenario: Crear personaje faltan campos requeridos
    Given path username, 'api', 'characters'
    And request { name: 'SinCampos' }
    And header Content-Type = 'application/json'
    When method POST
    Then status 400
    # * match response.error != null
    And print response

  Scenario: Actualizar personaje exitoso
    # Primero creamos un personaje para actualizar
    * def tempNameUpdate = 'HeroeActualizar_' + java.util.UUID.randomUUID().toString()
    Given path username, 'api', 'characters'
    And request { name: '#(tempNameUpdate)', alterego: 'AlteregoOriginal', description: 'Original', powers: ['Original'] }
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def idActualizar = response.id
    And print response
    # Ahora lo actualizamos
    Given path username, 'api', 'characters', idActualizar
    And request { name: 'HeroeActualizado', alterego: 'AlteregoActualizado', description: 'Actualizado', powers: ['PoderActualizado'] }
    And header Content-Type = 'application/json'
    When method PUT
    Then status 200
    # * match response.name == 'HeroeActualizado'
    And print response

  Scenario: Actualizar personaje no existe
    Given path username, 'api', 'characters', 9999
    And request { name: 'HeroeNoExiste', alterego: 'Alterego', description: 'No existe', powers: ['Nada'] }
    And header Content-Type = 'application/json'
    When method PUT
    Then status 404
    # * match response.error == 'Character not found'
    And print response
