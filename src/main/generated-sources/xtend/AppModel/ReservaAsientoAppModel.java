package AppModel;

import Dominio.Asiento;
import Dominio.Usuario;
import Dominio.Vuelo;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Observable
@Accessors
@SuppressWarnings("all")
public class ReservaAsientoAppModel {
  private Vuelo unVuelo;
  
  private Usuario unUsuario;
  
  private List<Asiento> asientos = CollectionLiterals.<Asiento>newArrayList();
  
  private Asiento asientoSeleccionado;
  
  public static int MAX_ASIENTO = 10;
  
  public ReservaAsientoAppModel(final Usuario usr, final Vuelo vuelo, final List<Asiento> asientosDisponibles) {
    this.unUsuario = usr;
    this.unVuelo = vuelo;
    this.asientos = asientosDisponibles;
  }
  
  public Iterable<Asiento> asientosDeFila(final int filaPedida) {
    final Function1<Asiento, Boolean> _function = new Function1<Asiento, Boolean>() {
      public Boolean apply(final Asiento it) {
        int _fila = it.getFila();
        return Boolean.valueOf((_fila == filaPedida));
      }
    };
    return IterableExtensions.<Asiento>filter(this.asientos, _function);
  }
  
  public boolean reservarAsiento() {
    boolean _xblockexpression = false;
    {
      this.asientoSeleccionado.setDuenio(this.unUsuario);
      List<Asiento> _asientosReservados = this.unUsuario.getAsientosReservados();
      _xblockexpression = _asientosReservados.add(this.asientoSeleccionado);
    }
    return _xblockexpression;
  }
  
  @Pure
  public Vuelo getUnVuelo() {
    return this.unVuelo;
  }
  
  public void setUnVuelo(final Vuelo unVuelo) {
    this.unVuelo = unVuelo;
  }
  
  @Pure
  public Usuario getUnUsuario() {
    return this.unUsuario;
  }
  
  public void setUnUsuario(final Usuario unUsuario) {
    this.unUsuario = unUsuario;
  }
  
  @Pure
  public List<Asiento> getAsientos() {
    return this.asientos;
  }
  
  public void setAsientos(final List<Asiento> asientos) {
    this.asientos = asientos;
  }
  
  @Pure
  public Asiento getAsientoSeleccionado() {
    return this.asientoSeleccionado;
  }
  
  public void setAsientoSeleccionado(final Asiento asientoSeleccionado) {
    this.asientoSeleccionado = asientoSeleccionado;
  }
}
