package Dominio;

import Dominio.Aeropuerto;
import Dominio.Asiento;
import Dominio.Escala;
import java.util.Date;
import java.util.List;

@SuppressWarnings("all")
public class Vuelo {
  private Aeropuerto origen;
  
  private Aeropuerto destino;
  
  private String aerolinea;
  
  private List<Asiento> asientos;
  
  private Date fechaSalida;
  
  private Date fechaLlegada;
  
  private List<Escala> escalas;
}
