import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  // Chama as modificação de contrução
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Construção do widget
  // Estudo de widgets de interação (Input de Texto, checkbox, ) -> formulário
  // Atributos
  // Chave de seleção dos componentes do formulário
  final _formKey = GlobalKey<FormState>();
  // Atributos do formulário
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _genero = "";
  String _dataNascimento = "";
  double _experiencia = 0;
  bool _aceite = false;

  // Métodos
  Widget build(BuildContext context) {
    // Construtor de Widgets
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Usuário"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Nome"),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? "Campo não Preenchido!!!"
                            : null, // Operador Ternário (Condição ? True : False)
                onSaved: (value) => _nome = value!, // Formulário
              ),
              SizedBox(height: 20,),
              // Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Email"),
                validator:
                    (value) =>
                        value!.contains("@") ? null : "digite um e-mail Válido",
                onSaved: (value) => _email = value!,
              ),
              // Campo Senha
              TextFormField(
                decoration: InputDecoration(labelText: "Insira uma Senha"),
                obscureText: true,
                validator: (value) => value!.length < 6 ? "Senha Fraca" : null,
                onSaved: (value) => _senha = value!,
              ),

              // Campo Gênero
              Text("Gênero: "),
              DropdownButtonFormField(
                items:
                    ["Masculino", "Feminino", "Outro"]
                        .map(
                          (String genero) => DropdownMenuItem(
                            value: genero,
                            child: Text(genero),
                          ),
                        )
                        .toList(),
                onChanged: (value) {},
                validator:
                    (value) => value == null ? "Selecione um Gênero" : null,
                onSaved: (value) => _genero = value!,
              ),
              // Campo Data de Nascimento
              TextFormField(
                decoration: InputDecoration(labelText: "Data de Nascimento"),
                validator:
                    (value) =>
                        value!.isEmpty ? "Informe a Data de Nascimento" : null,
                onSaved: (value) => _dataNascimento = value!,
              ),
              SizedBox(height: 20,),
              Text("Anos de Experiência"),
              // Slider de Seleção  -> Experiência
              Slider(
                value: _experiencia,
                min: 0,
                max: 30,
                divisions: 30,
                label: _experiencia.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _experiencia = value;
                  });
                },
              ),
              // Aceite dos Termos de Uso
              CheckboxListTile(
                value: _aceite,
                title: Text("Aceito os Termos de Uso"),
                onChanged: (value) {
                  setState(() {
                    _aceite = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _aceite) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Dados do Formulário"),
              content: Column(
                children: [Text("Nome: $_nome"), Text("Email: $_email")],
              ),
            ),
      );
    }
  }
}
