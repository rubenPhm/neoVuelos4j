package Dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Accessors
@Observable
@SuppressWarnings("all")
public class Aeropuerto {
  private String nombre;
  
  private String pais;
  
  public Aeropuerto(final String unNombre) {
    this.nombre = unNombre;
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public String getPais() {
    return this.pais;
  }
  
  public void setPais(final String pais) {
    this.pais = pais;
  }
}
