package AppModel;

import Dominio.Asiento;
import Dominio.Usuario;
import Dominio.Vuelo;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IntegerRange;
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
  
  public ReservaAsientoAppModel(final Usuario usr, final Vuelo vuelo) {
    this.unUsuario = usr;
    this.unVuelo = vuelo;
    this.initAsientos();
  }
  
  public ReservaAsientoAppModel() {
    this.initAsientos();
  }
  
  public void initAsientos() {
    IntegerRange _upTo = new IntegerRange(1, ReservaAsientoAppModel.MAX_ASIENTO);
    final Consumer<Integer> _function = new Consumer<Integer>() {
      public void accept(final Integer i) {
        Asiento _asiento = new Asiento((i).intValue(), "Pasillo");
        ReservaAsientoAppModel.this.asientos.add(_asiento);
        Asiento _asiento_1 = new Asiento((i).intValue(), "Centro");
        ReservaAsientoAppModel.this.asientos.add(_asiento_1);
        Asiento _asiento_2 = new Asiento((i).intValue(), "Ventanilla");
        ReservaAsientoAppModel.this.asientos.add(_asiento_2);
      }
    };
    _upTo.forEach(_function);
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
  
  public Object reservarAsiento() {
    return null;
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
