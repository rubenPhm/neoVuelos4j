package Dominio;

import Dominio.Aeropuerto;
import Dominio.Asiento;
import Dominio.Escala;
import Dominio.Usuario;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
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
  
  public Vuelo() {
    ArrayList<Escala> _arrayList = new ArrayList<Escala>();
    this.escalas = _arrayList;
    ArrayList<Asiento> _arrayList_1 = new ArrayList<Asiento>();
    this.asientos = _arrayList_1;
  }
  
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
  
  public boolean conDestino(final String destinoStr) {
    String _nombre = this.destino.getNombre();
    return _nombre.equals(destinoStr);
  }
  
  public boolean conOrigen(final String origenStr) {
    String _nombre = this.origen.getNombre();
    return _nombre.equals(origenStr);
  }
  
  public boolean contTarifaMenorA(final float tarifa) {
    boolean _and = false;
    boolean _notEquals = (!Objects.equal(this.asientos, null));
    if (!_notEquals) {
      _and = false;
    } else {
      List<Asiento> _asientosValorMaximo = this.asientosValorMaximo(tarifa);
      int _length = ((Object[])Conversions.unwrapArray(_asientosValorMaximo, Object.class)).length;
      boolean _lessThan = (0 < _length);
      _and = _lessThan;
    }
    return _and;
  }
  
  public List<Asiento> asientosValorMaximo(final float tarifa) {
    final Function1<Asiento, Boolean> _function = new Function1<Asiento, Boolean>() {
      public Boolean apply(final Asiento it) {
        float _precio = it.precio();
        return Boolean.valueOf((_precio < tarifa));
      }
    };
    Iterable<Asiento> _filter = IterableExtensions.<Asiento>filter(this.asientos, _function);
    return IterableExtensions.<Asiento>toList(_filter);
  }
  
  public String getNombreOrigen() {
    return this.origen.getNombre();
  }
  
  public String getNombreDestino() {
    return this.destino.getNombre();
  }
  
  public int getCantidadEscalas() {
    return this.escalas.size();
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
