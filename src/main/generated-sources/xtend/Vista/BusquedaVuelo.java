package Vista;

import AppModel.BusquedaVueloAppModel;
import Dominio.Vuelo;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.bindings.ObservableProperty;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.Selector;
import org.uqbar.arena.widgets.TextBox;
import org.uqbar.arena.widgets.tables.Column;
import org.uqbar.arena.widgets.tables.Table;
import org.uqbar.arena.windows.SimpleWindow;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.lacar.ui.model.ControlBuilder;

@SuppressWarnings("all")
public class BusquedaVuelo extends SimpleWindow<BusquedaVueloAppModel> {
  public BusquedaVuelo(final WindowOwner owner, final BusquedaVueloAppModel model) {
    super(owner, model);
    this.setTitle("Busqueda de vuelos");
  }
  
  protected void addActions(final Panel actionsPanel) {
  }
  
  protected void createFormPanel(final Panel mainPanel) {
    this.panelDeBusqueda(mainPanel);
    this.tablaResultados(mainPanel);
  }
  
  public TextBox panelDeBusqueda(final Panel mainPanel) {
    TextBox _xblockexpression = null;
    {
      Panel _panel = new Panel(mainPanel);
      HorizontalLayout _horizontalLayout = new HorizontalLayout();
      final Panel lineaTitulos = _panel.setLayout(_horizontalLayout);
      Panel _panel_1 = new Panel(mainPanel);
      HorizontalLayout _horizontalLayout_1 = new HorizontalLayout();
      final Panel lineaInputs = _panel_1.setLayout(_horizontalLayout_1);
      Label _label = new Label(lineaTitulos);
      _label.setText("Origen");
      Selector<String> _selector = new Selector<String>(lineaInputs);
      final Procedure1<Selector<String>> _function = new Procedure1<Selector<String>>() {
        public void apply(final Selector<String> it) {
          it.allowNull(true);
          it.bindValueToProperty("origen");
          BusquedaVueloAppModel _modelObject = BusquedaVuelo.this.getModelObject();
          ObservableProperty<Object> _observableProperty = new ObservableProperty<Object>(_modelObject, "todosLosAeropuertos");
          it.<Object>bindItems(_observableProperty);
        }
      };
      ObjectExtensions.<Selector<String>>operator_doubleArrow(_selector, _function);
      Label _label_1 = new Label(lineaTitulos);
      _label_1.setText("Destino");
      Selector<String> _selector_1 = new Selector<String>(lineaInputs);
      final Procedure1<Selector<String>> _function_1 = new Procedure1<Selector<String>>() {
        public void apply(final Selector<String> it) {
          it.allowNull(true);
          it.bindValueToProperty("destino");
          BusquedaVueloAppModel _modelObject = BusquedaVuelo.this.getModelObject();
          ObservableProperty<Object> _observableProperty = new ObservableProperty<Object>(_modelObject, "todosLosAeropuertos");
          it.<Object>bindItems(_observableProperty);
        }
      };
      ObjectExtensions.<Selector<String>>operator_doubleArrow(_selector_1, _function_1);
      Label _label_2 = new Label(lineaTitulos);
      _label_2.setText("Fecha Desde");
      TextBox _textBox = new TextBox(lineaInputs);
      final Procedure1<TextBox> _function_2 = new Procedure1<TextBox>() {
        public void apply(final TextBox it) {
          it.<Object, ControlBuilder>bindValueToProperty("fechaDesde");
          it.setWidth(150);
        }
      };
      ObjectExtensions.<TextBox>operator_doubleArrow(_textBox, _function_2);
      Label _label_3 = new Label(lineaTitulos);
      _label_3.setText("Fecha Hasta");
      TextBox _textBox_1 = new TextBox(lineaInputs);
      final Procedure1<TextBox> _function_3 = new Procedure1<TextBox>() {
        public void apply(final TextBox it) {
          it.<Object, ControlBuilder>bindValueToProperty("fechaHasta");
          it.setWidth(150);
        }
      };
      ObjectExtensions.<TextBox>operator_doubleArrow(_textBox_1, _function_3);
      Label _label_4 = new Label(lineaTitulos);
      _label_4.setText("Precio maximo");
      TextBox _textBox_2 = new TextBox(lineaInputs);
      final Procedure1<TextBox> _function_4 = new Procedure1<TextBox>() {
        public void apply(final TextBox it) {
          it.<Object, ControlBuilder>bindValueToProperty("tarifaMax");
          it.setWidth(150);
        }
      };
      _xblockexpression = ObjectExtensions.<TextBox>operator_doubleArrow(_textBox_2, _function_4);
    }
    return _xblockexpression;
  }
  
  public Column<Vuelo> tablaResultados(final Panel mainPanel) {
    Column<Vuelo> _xblockexpression = null;
    {
      Table<Vuelo> _table = new Table<Vuelo>(mainPanel, Vuelo.class);
      final Procedure1<Table<Vuelo>> _function = new Procedure1<Table<Vuelo>>() {
        public void apply(final Table<Vuelo> it) {
          it.bindItemsToProperty("resultados");
          it.<Object, ControlBuilder>bindValueToProperty("vueloSeleccionado");
        }
      };
      final Table<Vuelo> table = ObjectExtensions.<Table<Vuelo>>operator_doubleArrow(_table, _function);
      Column<Vuelo> _column = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_1 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("Origen");
          it.setFixedSize(200);
          it.bindContentsToProperty("origen");
        }
      };
      ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column, _function_1);
      Column<Vuelo> _column_1 = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_2 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("Destino");
          it.setFixedSize(100);
          it.bindContentsToProperty("destino");
        }
      };
      ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column_1, _function_2);
      Column<Vuelo> _column_2 = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_3 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("Salida");
          it.setFixedSize(200);
          it.bindContentsToProperty("fechaSalida");
        }
      };
      ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column_2, _function_3);
      Column<Vuelo> _column_3 = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_4 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("llegada");
          it.setFixedSize(200);
          it.bindContentsToProperty("fechaLlegada");
        }
      };
      ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column_3, _function_4);
      Column<Vuelo> _column_4 = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_5 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("llegada");
          it.setFixedSize(200);
          it.bindContentsToProperty("escalas.size()");
        }
      };
      ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column_4, _function_5);
      Column<Vuelo> _column_5 = new Column<Vuelo>(table);
      final Procedure1<Column<Vuelo>> _function_6 = new Procedure1<Column<Vuelo>>() {
        public void apply(final Column<Vuelo> it) {
          it.setTitle("Asientos Libres");
          it.setFixedSize(200);
          it.bindContentsToProperty("cantidadDeAsientosLibres");
        }
      };
      _xblockexpression = ObjectExtensions.<Column<Vuelo>>operator_doubleArrow(_column_5, _function_6);
    }
    return _xblockexpression;
  }
}
