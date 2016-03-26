package Repositorios;

import Dominio.Aeropuerto;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;

@SuppressWarnings("all")
public class AeropuertosRepositorio {
  private static AeropuertosRepositorio repositorio = null;
  
  public List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>();
  
  public AeropuertosRepositorio() {
    Aeropuerto _aeropuerto = new Aeropuerto("Buenos Aires", "Argentina");
    this.todosLosAeropuertos.add(_aeropuerto);
  }
  
  public static AeropuertosRepositorio getInstance() {
    AeropuertosRepositorio _xblockexpression = null;
    {
      boolean _equals = Objects.equal(AeropuertosRepositorio.repositorio, null);
      if (_equals) {
        AeropuertosRepositorio _aeropuertosRepositorio = new AeropuertosRepositorio();
        AeropuertosRepositorio.repositorio = _aeropuertosRepositorio;
      }
      _xblockexpression = AeropuertosRepositorio.repositorio;
    }
    return _xblockexpression;
  }
  
  public List<String> nombreDeTodosLosAeropuertos() {
    final Function1<Aeropuerto, String> _function = new Function1<Aeropuerto, String>() {
      public String apply(final Aeropuerto aeropuerto) {
        return aeropuerto.getNombre();
      }
    };
    List<String> _map = ListExtensions.<Aeropuerto, String>map(this.todosLosAeropuertos, _function);
    return IterableExtensions.<String>toList(_map);
  }
}
