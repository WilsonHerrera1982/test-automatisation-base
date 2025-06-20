package com.pichincha.features.marvelcharactersapi;

import com.intuit.karate.junit5.Karate;

public class MarvelCharactersApiTest {
    @Karate.Test
    Karate testPersonajesConsulta() {
        return Karate.run("personajes_consulta.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate testPersonajesCreacionActualizacion() {
        return Karate.run("personajes_creacion_actualizacion.feature").relativeTo(getClass());
    }

    @Karate.Test
    Karate testPersonajesEliminacion() {
        return Karate.run("personajes_eliminacion.feature").relativeTo(getClass());
    }
}
