package Dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Observable
@Accessors
@SuppressWarnings("all")
public class Tarifa {
  private int precio;
  
  @Pure
  public int getPrecio() {
    return this.precio;
  }
  
  public void setPrecio(final int precio) {
    this.precio = precio;
  }
}
