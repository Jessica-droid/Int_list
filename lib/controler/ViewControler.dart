import 'package:flutter/cupertino.dart';

class HomeControler {
  HomeControler();

  String validarCampo(String entrada, String msgValorInvalido,
      String msgCampoVazio, TextEditingController campoControler) {
    if (entrada.isEmpty) {
      return msgCampoVazio;
    } else {
      //Campo preenchido, validar formato
      if (_converterValor(entrada) == null) {
        //Erro de formato, notificar
        return msgValorInvalido;
      } else
        return null;
    }
  }

  void adicionarEntrada(
      String entrada, List<int> lista, GlobalKey<FormState> formKey) {
    //Verificar se o formulario esta ok
    if (_formularioValidado(formKey)) {
      //Dados validados, inserir
      _adicionarNaLista(_converterValor(entrada), lista);

      //limpar formulatio
      formKey.currentState.reset();
    }
  }

  List<int> retornarSaida(List<int> listaEntrada) {
    List<int> valoresNaoRepetidos = List();

    //Criando uma nova lista com valores nao repetidos
    listaEntrada.forEach((valor) {
      if (!valoresNaoRepetidos.contains(valor)) {
        //Se o valor inserido ainda nao existe nesta lista, adicionar
        valoresNaoRepetidos.add(valor);
      }
    });

    valoresNaoRepetidos.sort();
    return valoresNaoRepetidos;
  }

  int _converterValor(String valor) {
    return int.tryParse(valor) ?? null;
  }

  void _adicionarNaLista(int entrada, List<int> lista) {
    lista.add(entrada);
  }

  bool _formularioValidado(GlobalKey<FormState> formKey) {
    return formKey.currentState.validate();
  }
}
