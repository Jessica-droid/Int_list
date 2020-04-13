import 'package:flutter/material.dart';
import 'package:intlist/controler/ViewControler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _entradaControler = TextEditingController();
  List<int> listaEntrada = List();
  List<int> listaSaida = List();
  HomeControler vControler = HomeControler();
  String msg = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IntList")),
      body: SafeArea(
        child: _content(),
      ),
    );
  }

  //Area de trabalho
  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_areaEntrada(), SizedBox(height: 24), _areaExibicao()],
    );
  }

  Widget _areaEntrada() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Descrição
            Text("Adicionar número:",
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),

            SizedBox(height: 16),

            //Campo de entrada
            TextFormField(
                controller: _entradaControler,
                decoration: InputDecoration(
                    hintText: "Insira um número inteiro",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: 1,
                            style: BorderStyle.solid))),
                keyboardType: TextInputType.number,
                validator: (entrada) => vControler.validarCampo(
                    entrada,
                    "Formato de entrada inválido",
                    "Este campo é de preenchimento obrigatório",
                    _entradaControler)),

            SizedBox(height: 24),

            //Botoes de acao
            _acoes(),

            SizedBox(height: 16),

            RaisedButton(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                color: Colors.blueGrey[300],
                child: Text("LIMPAR DADOS",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                onPressed: () {
                  setState(() {
                    //Limpando lista e formulario
                    _formKey.currentState.reset();
                    listaSaida.clear();
                    listaEntrada.clear();
                    msg = "";
                  });
                })
            //Limpar lista
          ],
        ),
      ),
    );
  }

  Widget _acoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Confirmar
        Expanded(
          child: RaisedButton(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            color: Colors.blueGrey[300],
            child: Text("ADICIONAR",
                style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: () => vControler.adicionarEntrada(
                _entradaControler.text.toString(), listaEntrada, _formKey),
          ),
        ),

        SizedBox(width: 16),

        //Exbir entradas
        Expanded(
          child: RaisedButton(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Colors.blueGrey[300],
              child: Text("EXIBIR ENTRADAS",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                //Verificando se há dados para exibir
                if (listaEntrada.isEmpty) {
                  //Sem dados, informar
                  setState(() {
                    msg = "Não hà dados a serem exibidos";
                  });
                } else {
                  //Atualizando lista de saida
                  setState(() {
                    msg = "Números inteiros registrados:";

                    listaSaida = vControler.retornarSaida(listaEntrada);
                  });
                }
              }),
        )
      ],
    );
  }

  Widget _areaExibicao() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Label
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(msg,
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ),

          SizedBox(height: 16),

          //Lista de saída
          Expanded(
            child: ListView.builder(
                itemCount: listaSaida.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(listaSaida[position].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.blueGrey[400])),
                  );
                },
                scrollDirection: Axis.vertical,
                reverse: false),
          ),
        ],
      ),
    );
  }
}
