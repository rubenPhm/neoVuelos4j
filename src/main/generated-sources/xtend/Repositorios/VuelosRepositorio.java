package Repositorios;

import Dominio.Vuelo;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class VuelosRepositorio {
  private static VuelosRepositorio repositorio = null;
  
  public List<Vuelo> todosLosVuelos = new ArrayList<Vuelo>();
  
  protected VuelosRepositorio() {
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
  
  @Pure
  public List<Vuelo> getTodosLosVuelos() {
    return this.todosLosVuelos;
  }
  
  public void setTodosLosVuelos(final List<Vuelo> todosLosVuelos) {
    this.todosLosVuelos = todosLosVuelos;
  }
}
