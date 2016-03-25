package Dominio;

import Dominio.Aeropuerto;
import Dominio.Asiento;
import Dominio.Escala;
import Dominio.Tarifa;
import Dominio.Usuario;
import com.google.common.base.Objects;
import java.util.Date;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class Vuelo {
  private Aeropuerto origen;
  
  private Aeropuerto destino;
  
  private String aerolinea;
  
  private List<Asiento> asientos;
  
  private Date fechaSalida;
  
  private Date fechaLlegada;
  
  private List<Escala> escalas;
  
  public int getCantidadDeAsientosLibres() {
    final Function1<Asiento, Boolean> _function = new Function1<Asiento, Boolean>() {
      public Boolean apply(final Asiento asiento) {
        Usuario _duenio = asiento.getDuenio();
        return Boolean.valueOf(Objects.equal(_duenio, null));
      }
    };
    Iterable<Asiento> _filter = IterableExtensions.<Asiento>filter(this.asientos, _function);
    List<Asiento> _list = IterableExtensions.<Asiento>toList(_filter);
    return _list.size();
  }
  
  public List<Asiento> obtenerAsientosQueValganMenosQue(final int precio) {
    final Function1<Asiento, Boolean> _function = new Function1<Asiento, Boolean>() {
      public Boolean apply(final Asiento asiento) {
        Tarifa _tarifa = asiento.getTarifa();
        int _precio = _tarifa.getPrecio();
        return Boolean.valueOf((_precio < precio));
      }
    };
    Iterable<Asiento> _filter = IterableExtensions.<Asiento>filter(this.asientos, _function);
    return IterableExtensions.<Asiento>toList(_filter);
  }
  
  @Pure
  public Aeropuerto getOrigen() {
    return this.origen;
  }
  
  public void setOrigen(final Aeropuerto origen) {
    this.origen = origen;
  }
  
  @Pure
  public Aeropuerto getDestino() {
    return this.destino;
  }
  
  public void setDestino(final Aeropuerto destino) {
    this.destino = destino;
  }
  
  @Pure
  public String getAerolinea() {
    return this.aerolinea;
  }
  
  public void setAerolinea(final String aerolinea) {
    this.aerolinea = aerolinea;
  }
  
  @Pure
  public List<Asiento> getAsientos() {
    return this.asientos;
  }
  
  public void setAsientos(final List<Asiento> asientos) {
    this.asientos = asientos;
  }
  
  @Pure
  public Date getFechaSalida() {
    return this.fechaSalida;
  }
  
  public void setFechaSalida(final Date fechaSalida) {
    this.fechaSalida = fechaSalida;
  }
  
  @Pure
  public Date getFechaLlegada() {
    return this.fechaLlegada;
  }
  
  public void setFechaLlegada(final Date fechaLlegada) {
    this.fechaLlegada = fechaLlegada;
  }
  
  @Pure
  public List<Escala> getEscalas() {
    return this.escalas;
  }
  
  public void setEscalas(final List<Escala> escalas) {
    this.escalas = escalas;
  }
}
