package Repositorios;

import Dominio.Vuelo;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
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
  
  @Pure
  public List<Vuelo> getTodosLosVuelos() {
    return this.todosLosVuelos;
  }
  
  public void setTodosLosVuelos(final List<Vuelo> todosLosVuelos) {
    this.todosLosVuelos = todosLosVuelos;
  }
}
