package Repositorios;

import Dominio.Aeropuerto;
import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("all")
public class AeropuertosRepositorio {
  private static AeropuertosRepositorio repositorio = null;
  
  public List<Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>();
  
  public AeropuertosRepositorio() {
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
}
