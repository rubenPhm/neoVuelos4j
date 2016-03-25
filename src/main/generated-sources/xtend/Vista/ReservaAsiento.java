package Vista;

import AppModel.ReservaAsientoAppModel;
import Dominio.Asiento;
import java.awt.Color;
import java.util.function.Consumer;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.aop.windows.TransactionalDialog;
import org.uqbar.arena.bindings.ObservableValue;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.layout.VerticalLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.Control;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.List;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.Selector;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.arena.xtend.ArenaXtendExtensions;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import org.uqbar.lacar.ui.model.ListBuilder;
import org.uqbar.lacar.ui.model.bindings.Binding;

@SuppressWarnings("all")
public class ReservaAsiento extends TransactionalDialog<ReservaAsientoAppModel> {
  public ReservaAsiento(final WindowOwner parent, final ReservaAsientoAppModel model) {
    super(parent, model);
  }
  
  protected void addActions(final Panel actionsPanel) {
  }
  
  protected void createFormPanel(final Panel mainPanel) {
    Panel _panel = new Panel(mainPanel);
    HorizontalLayout _horizontalLayout = new HorizontalLayout();
    final Panel linea1 = _panel.setLayout(_horizontalLayout);
    Panel _panel_1 = new Panel(linea1);
    VerticalLayout _verticalLayout = new VerticalLayout();
    final Panel columna1 = _panel_1.setLayout(_verticalLayout);
    Label _label = new Label(columna1);
    final Procedure1<Label> _function = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Usuario");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label, _function);
    Label _label_1 = new Label(columna1);
    ObservableValue<Control, ControlBuilder> _value = _label_1.<ControlBuilder>value();
    ArenaXtendExtensions.operator_spaceship(_value, "unUsuario.nombre");
    Panel _panel_2 = new Panel(mainPanel);
    HorizontalLayout _horizontalLayout_1 = new HorizontalLayout();
    final Panel linea2 = _panel_2.setLayout(_horizontalLayout_1);
    Panel _panel_3 = new Panel(linea2);
    VerticalLayout _verticalLayout_1 = new VerticalLayout();
    final Panel columna2 = _panel_3.setLayout(_verticalLayout_1);
    Label _label_2 = new Label(columna2);
    final Procedure1<Label> _function_1 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Tramos");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_2, _function_1);
    Panel _panel_4 = new Panel(columna2);
    final Procedure1<Panel> _function_2 = new Procedure1<Panel>() {
      public void apply(final Panel it) {
        HorizontalLayout _horizontalLayout = new HorizontalLayout();
        it.setLayout(_horizontalLayout);
        List<Object> _list = new List<Object>(it);
        final Procedure1<List<Object>> _function = new Procedure1<List<Object>>() {
          public void apply(final List<Object> it) {
            Binding<?, Selector<Object>, ListBuilder<Object>> propiedadCondimentos = it.bindItemsToProperty("unVuelo.escalas");
          }
        };
        ObjectExtensions.<List<Object>>operator_doubleArrow(_list, _function);
      }
    };
    ObjectExtensions.<Panel>operator_doubleArrow(_panel_4, _function_2);
    Panel _panel_5 = new Panel(linea2);
    VerticalLayout _verticalLayout_2 = new VerticalLayout();
    final Panel columna3 = _panel_5.setLayout(_verticalLayout_2);
    Label _label_3 = new Label(columna3);
    final Procedure1<Label> _function_3 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Aerolinea");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_3, _function_3);
    Label _label_4 = new Label(columna3);
    ObservableValue<Control, ControlBuilder> _value_1 = _label_4.<ControlBuilder>value();
    ArenaXtendExtensions.operator_spaceship(_value_1, "unVuelo.aerolinea");
    Label _label_5 = new Label(mainPanel);
    final Procedure1<Label> _function_4 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Asientos");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_5, _function_4);
    IntegerRange _upTo = new IntegerRange(1, ReservaAsientoAppModel.MAX_ASIENTO);
    final Consumer<Integer> _function_5 = new Consumer<Integer>() {
      public void accept(final Integer i) {
        final Panel filaPanel = new Panel(mainPanel);
        HorizontalLayout _horizontalLayout = new HorizontalLayout();
        filaPanel.setLayout(_horizontalLayout);
        ReservaAsientoAppModel _modelObject = ReservaAsiento.this.getModelObject();
        Iterable<Asiento> _asientosDeFila = _modelObject.asientosDeFila((i).intValue());
        final Consumer<Asiento> _function = new Consumer<Asiento>() {
          public void accept(final Asiento asiento) {
            Button _button = new Button(filaPanel);
            final Procedure1<Button> _function = new Procedure1<Button>() {
              public void apply(final Button it) {
                boolean _disponible = asiento.getDisponible();
                if (_disponible) {
                  it.setBackground(Color.GREEN);
                } else {
                  it.setBackground(Color.RED);
                }
                String _string = asiento.toString();
                it.setCaption(_string);
                final Action _function = new Action() {
                  public void execute() {
                    ReservaAsientoAppModel _modelObject = ReservaAsiento.this.getModelObject();
                    _modelObject.setAsientoSeleccionado(asiento);
                  }
                };
                it.onClick(_function);
              }
            };
            ObjectExtensions.<Button>operator_doubleArrow(_button, _function);
          }
        };
        _asientosDeFila.forEach(_function);
      }
    };
    _upTo.forEach(_function_5);
    Panel _panel_6 = new Panel(mainPanel);
    HorizontalLayout _horizontalLayout_2 = new HorizontalLayout();
    final Panel linea3 = _panel_6.setLayout(_horizontalLayout_2);
    Panel _panel_7 = new Panel(linea3);
    VerticalLayout _verticalLayout_3 = new VerticalLayout();
    final Panel columna4 = _panel_7.setLayout(_verticalLayout_3);
    Label _label_6 = new Label(columna4);
    final Procedure1<Label> _function_6 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Asiento seleccionado");
        it.setForeground(Color.BLUE);
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_6, _function_6);
    Label _label_7 = new Label(columna4);
    ObservableValue<Control, ControlBuilder> _value_2 = _label_7.<ControlBuilder>value();
    ArenaXtendExtensions.operator_spaceship(_value_2, "asientoSeleccionado");
    Panel _panel_8 = new Panel(linea3);
    VerticalLayout _verticalLayout_4 = new VerticalLayout();
    final Panel linea4 = _panel_8.setLayout(_verticalLayout_4);
    Label _label_8 = new Label(linea4);
    final Procedure1<Label> _function_7 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Monto a Pagar");
        it.setForeground(Color.BLUE);
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_8, _function_7);
    Label _label_9 = new Label(linea4);
    ObservableValue<Control, ControlBuilder> _value_3 = _label_9.<ControlBuilder>value();
    ArenaXtendExtensions.operator_spaceship(_value_3, "asientoSeleccionado.tarifa.precio");
    Panel _panel_9 = new Panel(linea3);
    VerticalLayout _verticalLayout_5 = new VerticalLayout();
    final Panel linea5 = _panel_9.setLayout(_verticalLayout_5);
    Button _button = new Button(linea5);
    final Procedure1<Button> _function_8 = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Reservar");
        final Action _function = new Action() {
          public void execute() {
            ReservaAsientoAppModel _modelObject = ReservaAsiento.this.getModelObject();
            _modelObject.reservarAsiento();
            ReservaAsiento.this.accept();
          }
        };
        it.onClick(_function);
        it.setAsDefault();
        it.disableOnError();
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button, _function_8);
  }
}
