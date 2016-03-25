package Repositorios;

import Dominio.Vuelo;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class VuelosRepositorio {
  private static VuelosRepositorio repositorio = null;
  
  private List<Vuelo> todosLosVuelos = new ArrayList<Vuelo>();
  
  public VuelosRepositorio() {
  }
  
  public static VuelosRepositorio getInstance() {
    VuelosRepositorio _xblockexpression = null;
    {
      boolean _equals = Objects.equal(VuelosRepositorio.repositorio, null);
      if (_equals) {
        VuelosRepositorio _vuelosRepositorio = new VuelosRepositorio();
        VuelosRepositorio.repositorio = _vuelosRepositorio;
      }
      _xblockexpression = VuelosRepositorio.repositorio;
    }
    return _xblockexpression;
  }
  
  public List<Vuelo> obtenerVuelosQueCumplanCon(final Vuelo vuelo) {
    final Function1<Vuelo, Boolean> _function = new Function1<Vuelo, Boolean>() {
      public Boolean apply(final Vuelo unVuelo) {
        return Boolean.valueOf(unVuelo.equals(vuelo));
      }
    };
    Iterable<Vuelo> _filter = IterableExtensions.<Vuelo>filter(this.todosLosVuelos, _function);
    final List<Vuelo> vuelos = IterableExtensions.<Vuelo>toList(_filter);
    return vuelos;
  }
}
