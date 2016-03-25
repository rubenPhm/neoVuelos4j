package AppModel;

import Dominio.Aeropuerto;
import Dominio.Asiento;
import Dominio.Busqueda;
import Dominio.Usuario;
import Dominio.Vuelo;
import Repositorios.AeropuertosRepositorio;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class BusquedaVueloAppModel {
  private Aeropuerto origen;
  
  private Aeropuerto destino;
  
  private Date fechaDesde;
  
  private Date fechaHasta;
  
  private int tarifaMax;
  
  private Aeropuerto vueloSeleccionado;
  
  private List<Vuelo> resultados;
  
  private Usuario usr;
  
  private List<Aeropuerto> todosLosAeropuertos;
  
  private Map<Vuelo, List<Asiento>> asientosPorVuelo;
  
  public BusquedaVueloAppModel(final Usuario unUsr) {
    this.usr = unUsr;
    AeropuertosRepositorio _instance = AeropuertosRepositorio.getInstance();
    this.todosLosAeropuertos = _instance.todosLosAeropuertos;
  }
  
  public void buscar() {
    Vuelo vuelo = new Vuelo();
    vuelo.setOrigen(this.origen);
    vuelo.setDestino(this.destino);
    vuelo.setFechaLlegada(this.fechaHasta);
    vuelo.setFechaSalida(this.fechaDesde);
    final Busqueda busqueda = new Busqueda();
    busqueda.buscarVuelo(vuelo, this.usr);
    this.resultados = busqueda.resultados;
    final Function1<Vuelo, Boolean> _function = new Function1<Vuelo, Boolean>() {
      public Boolean apply(final Vuelo unVuelo) {
        List<Asiento> _obtenerAsientosQueValganMenosQue = unVuelo.obtenerAsientosQueValganMenosQue(BusquedaVueloAppModel.this.tarifaMax);
        int _size = _obtenerAsientosQueValganMenosQue.size();
        return Boolean.valueOf((_size > 0));
      }
    };
    Iterable<Vuelo> _filter = IterableExtensions.<Vuelo>filter(this.resultados, _function);
    IterableExtensions.<Vuelo>toList(_filter);
    for (final Vuelo unVuelo : this.resultados) {
      List<Asiento> _obtenerAsientosQueValganMenosQue = vuelo.obtenerAsientosQueValganMenosQue(this.tarifaMax);
      this.asientosPorVuelo.put(vuelo, _obtenerAsientosQueValganMenosQue);
    }
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
  public Date getFechaDesde() {
    return this.fechaDesde;
  }
  
  public void setFechaDesde(final Date fechaDesde) {
    this.fechaDesde = fechaDesde;
  }
  
  @Pure
  public Date getFechaHasta() {
    return this.fechaHasta;
  }
  
  public void setFechaHasta(final Date fechaHasta) {
    this.fechaHasta = fechaHasta;
  }
  
  @Pure
  public int getTarifaMax() {
    return this.tarifaMax;
  }
  
  public void setTarifaMax(final int tarifaMax) {
    this.tarifaMax = tarifaMax;
  }
  
  @Pure
  public Aeropuerto getVueloSeleccionado() {
    return this.vueloSeleccionado;
  }
  
  public void setVueloSeleccionado(final Aeropuerto vueloSeleccionado) {
    this.vueloSeleccionado = vueloSeleccionado;
  }
  
  @Pure
  public List<Vuelo> getResultados() {
    return this.resultados;
  }
  
  public void setResultados(final List<Vuelo> resultados) {
    this.resultados = resultados;
  }
  
  @Pure
  public Usuario getUsr() {
    return this.usr;
  }
  
  public void setUsr(final Usuario usr) {
    this.usr = usr;
  }
  
  @Pure
  public List<Aeropuerto> getTodosLosAeropuertos() {
    return this.todosLosAeropuertos;
  }
  
  public void setTodosLosAeropuertos(final List<Aeropuerto> todosLosAeropuertos) {
    this.todosLosAeropuertos = todosLosAeropuertos;
  }
  
  @Pure
  public Map<Vuelo, List<Asiento>> getAsientosPorVuelo() {
    return this.asientosPorVuelo;
  }
  
  public void setAsientosPorVuelo(final Map<Vuelo, List<Asiento>> asientosPorVuelo) {
    this.asientosPorVuelo = asientosPorVuelo;
  }
}
