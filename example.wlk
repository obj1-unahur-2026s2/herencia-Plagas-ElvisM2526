//Elementos que pueden ser atacados.

class Hogar {
  var nivelDeMugre
  const property confortQueOfrece
  
  method nivelDeMugre() = nivelDeMugre
  method confortQueOfrece() = confortQueOfrece

  method esBueno() {
    return nivelDeMugre <= confortQueOfrece / 2
  }

  method recibirAtaqueDe(unaPlaga) {
    nivelDeMugre += unaPlaga.nivelDeDanio()
  }
}

object nivelDeHuerta {
  var nivel = 20
  
  method nivel() = nivel
}

class Huerta {
  var capacidadDeProducción
  
  method capacidadDeProducción() = capacidadDeProducción

  method esBueno() {
    return capacidadDeProducción > nivelDeHuerta.nivel()
  }

  method recibirAtaqueDe(unaPlaga) {
    capacidadDeProducción -= unaPlaga.nivelDeDanio() * 0.1
    if(unaPlaga.transmitirEnfermedades()) {
      capacidadDeProducción -= 10
    }
  }
}

class Mascota {
  var nivelDeSalud
  
  method nivelDeSalud() = nivelDeSalud

  method esBueno() {
    return nivelDeSalud > 250
  }

  method recibirAtaqueDe(unaPlaga) {
    if(unaPlaga.transmitirEnfermedades()){
      nivelDeSalud -= unaPlaga.nivelDeDanio()
    }
  }
}

class Barrio {
  var listaElementos = []

  method listaElementos() = listaElementos

  method esElementoBueno() {
    return listaElementos.filter({unElemento => unElemento.esBueno()})
  }
  
  method cantidadDeBuenos() {
    return listaElementos.count({unElemento => unElemento.esBueno()})
  }
   
  method cantidadDeMalos() {
    return listaElementos.count({unElemento => not unElemento.esBueno()})
  }

  method esCopado() {
    return self.cantidadDeBuenos() > self.cantidadDeMalos()
  }
}

//Plagas

class Plaga {
  var poblacion

  method poblacion() = poblacion

  method transmitirEnfermedades() {
    return poblacion >= 10
  }

  method efectosDeAtaque() {
    poblacion += (poblacion * 0.1)
  }

  method atacar(unElemento) {
    unElemento.recibirAtaqueDe(self)
    self.efectosDeAtaque()
  }
}

class Cucarachas inherits Plaga {
  var pesoGramos 

  method pesoPromedio() = pesoGramos

  method nivelDeDanio() {
    return poblacion / 2
  }

  override method transmitirEnfermedades() {
    return super() and self.pesoPromedio() >= 10
  }

  override method efectosDeAtaque() {
    super()
    pesoGramos += 2
  }
}

class Pulgas inherits Plaga {

  method nivelDeDanio() {
    return poblacion * 2
  }
}

class Garrapatas inherits Pulgas {

  override method efectosDeAtaque() {
    poblacion += (poblacion * 0.2)
  }
}

class Mosquitos inherits Plaga{
  
  method nivelDeDanio() {
    return poblacion
  }

  override method transmitirEnfermedades() {
    return super() and poblacion % 3 == 0
  }
}