package AppModel;

import Dominio.Asiento;
import Dominio.Busqueda;
import Dominio.Usuario;
import Dominio.Vuelo;
import Repositorios.AeropuertosRepositorio;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class BusquedaVueloAppModel {
  private Usuario usr;
  
  private List<String> todosLosAeropuertos;
  
  private String origen;
  
  private String destino;
  
  private Date fechaDesde;
  
  private Date fechaHasta;
  
  private String tarifaMax;
  
  private Vuelo vueloSeleccionado;
  
  private List<Vuelo> resultados;
  
  private Map<Vuelo, List<Asiento>> asientosPorVuelo;
  
  private List<Asiento> asientosDisponibles;
  
  public BusquedaVueloAppModel(final Usuario unUsr) {
    this.usr = unUsr;
    AeropuertosRepositorio _instance = AeropuertosRepositorio.getInstance();
    List<String> _nombreDeTodosLosAeropuertos = _instance.nombreDeTodosLosAeropuertos();
    this.todosLosAeropuertos = _nombreDeTodosLosAeropuertos;
  }
  
  public List<Vuelo> buscar() {
    Busqueda _busqueda = new Busqueda(this.origen, this.destino, this.fechaDesde, this.fechaHasta, this.tarifaMax);
    List<Vuelo> _buscar = _busqueda.buscar(this.usr);
    return this.resultados = _buscar;
  }
  
  public List<Asiento> separarAsientos() {
    float _parseFloat = Float.parseFloat(this.tarifaMax);
    List<Asiento> _asientosValorMaximo = this.vueloSeleccionado.asientosValorMaximo(_parseFloat);
    return this.asientosDisponibles = _asientosValorMaximo;
  }
  
  @Pure
  public Usuario getUsr() {
    return this.usr;
  }
  
  public void setUsr(final Usuario usr) {
    this.usr = usr;
  }
  
  @Pure
  public List<String> getTodosLosAeropuertos() {
    return this.todosLosAeropuertos;
  }
  
  public void setTodosLosAeropuertos(final List<String> todosLosAeropuertos) {
    this.todosLosAeropuertos = todosLosAeropuertos;
  }
  
  @Pure
  public String getOrigen() {
    return this.origen;
  }
  
  public void setOrigen(final String origen) {
    this.origen = origen;
  }
  
  @Pure
  public String getDestino() {
    return this.destino;
  }
  
  public void setDestino(final String destino) {
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
  public String getTarifaMax() {
    return this.tarifaMax;
  }
  
  public void setTarifaMax(final String tarifaMax) {
    this.tarifaMax = tarifaMax;
  }
  
  @Pure
  public Vuelo getVueloSeleccionado() {
    return this.vueloSeleccionado;
  }
  
  public void setVueloSeleccionado(final Vuelo vueloSeleccionado) {
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
  public Map<Vuelo, List<Asiento>> getAsientosPorVuelo() {
    return this.asientosPorVuelo;
  }
  
  public void setAsientosPorVuelo(final Map<Vuelo, List<Asiento>> asientosPorVuelo) {
    this.asientosPorVuelo = asientosPorVuelo;
  }
  
  @Pure
  public List<Asiento> getAsientosDisponibles() {
    return this.asientosDisponibles;
  }
  
  public void setAsientosDisponibles(final List<Asiento> asientosDisponibles) {
    this.asientosDisponibles = asientosDisponibles;
  }
}
