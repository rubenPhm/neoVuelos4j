package AppModel;

import Dominio.Aeropuerto;
import Dominio.Usuario;
import Repositorios.AeropuertosRepositorio;
import java.util.Date;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;
import scala.Int;

@Accessors
@Observable
@SuppressWarnings("all")
public class BusquedaVueloAppModel {
  private Aeropuerto origen;
  
  private Aeropuerto destino;
  
  private Date fechaDesde;
  
  private Date fechaHasta;
  
  private Int tarifaMax;
  
  private Aeropuerto vueloSeleccionado;
  
  private List<Aeropuerto> resultados;
  
  private Usuario usr;
  
  private List<Aeropuerto> todosLosAeropuertos;
  
  public BusquedaVueloAppModel(final Usuario unUsr) {
    this.usr = unUsr;
    AeropuertosRepositorio _instance = AeropuertosRepositorio.getInstance();
    this.todosLosAeropuertos = _instance.todosLosAeropuertos;
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
  public Int getTarifaMax() {
    return this.tarifaMax;
  }
  
  public void setTarifaMax(final Int tarifaMax) {
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
  public List<Aeropuerto> getResultados() {
    return this.resultados;
  }
  
  public void setResultados(final List<Aeropuerto> resultados) {
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
}
