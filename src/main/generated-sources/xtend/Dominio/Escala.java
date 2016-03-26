package Dominio;

import Dominio.Aeropuerto;
import java.util.Date;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Escala {
  private Aeropuerto destino;
  
  private Date horaLlegada;
  
  private Date horaSalida;
  
  @Pure
  public Aeropuerto getDestino() {
    return this.destino;
  }
  
  public void setDestino(final Aeropuerto destino) {
    this.destino = destino;
  }
  
  @Pure
  public Date getHoraLlegada() {
    return this.horaLlegada;
  }
  
  public void setHoraLlegada(final Date horaLlegada) {
    this.horaLlegada = horaLlegada;
  }
  
  @Pure
  public Date getHoraSalida() {
    return this.horaSalida;
  }
  
  public void setHoraSalida(final Date horaSalida) {
    this.horaSalida = horaSalida;
  }
}
