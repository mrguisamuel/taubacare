import 'package:flutter/material.dart';
import '../widgets/mytextfield.dart';
import '../widgets/mybutton.dart';
import '../services/database.dart';
import '../utilities/alltypes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utilities/colors.dart';

class RegisterOrganization extends StatefulWidget {
	const RegisterOrganization({Key? key}) : super(key: key);
	
	@override
	State<RegisterOrganization> createState() => _RegisterOrganizationState();
}

class _RegisterOrganizationState extends State<RegisterOrganization> {
	List<TextEditingController> _controllers = [
		TextEditingController(),
		TextEditingController(),
		TextEditingController(),
		TextEditingController(),
		TextEditingController()
	];
	MyDatabase _database = MyDatabase();
	OrganizationType? _org = OrganizationType.education;
	
	@override
	Widget build(BuildContext context) {
		var size = MediaQuery.of(context).size;
		return Scaffold(
			backgroundColor: ProjectColors.lowRed,
			resizeToAvoidBottomInset: true,
			appBar: AppBar(
				elevation: 0,
				backgroundColor: ProjectColors.white,
				foregroundColor: ProjectColors.black,
				title: Text('Cadastro de instituição'),
				leading: IconButton(
					icon: Icon(Icons.arrow_back),
					onPressed: () => Navigator.of(context).pushReplacementNamed('/home')
				)
			),
			body: SafeArea(
				child: SingleChildScrollView(
					child: Center(
						child: Column(
							children: <Widget>[
								Row(
									children: <Widget>[
										Radio<OrganizationType>(
											value: OrganizationType.education,
											groupValue: this._org,
											onChanged: (OrganizationType? value) => setState(() => this._org = value)
										),
										Text('Educação', style: TextStyle(fontFamily: 'Poppins')),
										Radio<OrganizationType>(
											value: OrganizationType.assistance,
											groupValue: this._org,
											onChanged: (OrganizationType? value) => setState(() => this._org = value)
										),
										Text('Assistência', style: TextStyle(fontFamily: 'Poppins')),
										Radio<OrganizationType>(
											value: OrganizationType.sports,
											groupValue: this._org,
											onChanged: (OrganizationType? value) => setState(() => this._org = value)
										),
										Text('Esportes', style: TextStyle(fontFamily: 'Poppins'))
									]
								),
								RegisterTextField(
									icon: Icons.star_rounded,
									hintText: 'Digite o nome',
									validatorText: 'Insira um nome válido',
									controller: this._controllers[0]
								),
								RegisterTextField(
									icon: Icons.alternate_email_rounded,
									hintText: 'Digite o e-mail',
									validatorText: 'Insira um e-mail válido',
									controller: this._controllers[1]
								),
								RegisterTextField(
									icon: Icons.calendar_month,
									hintText: 'Digite o ano de fundação',
									validatorText: 'Insira um ano válido',
									controller: this._controllers[2]
								),
								RegisterTextField(
									icon: Icons.contact_phone,
									hintText: 'Digite um telefone de contato',
									validatorText: 'Insira um telefone válido',
									controller: this._controllers[3]
								),
								RegisterTextField(
									icon: Icons.account_balance_rounded,
									hintText: 'Digite um endereço',
									validatorText: 'Insira um endereço válido',
									controller: this._controllers[4]
								),
								MyButton(
									width: size.width * 0.8,
									message: 'Cadastrar',
									action: () {
										_database.insertOrganization(
											name: this._controllers[0].text.toString(),
											email: this._controllers[1].text.toString(),
											year: this._controllers[2].text.toString(),
											phone: this._controllers[3].text.toString(),
											address: this._controllers[4].text.toString(),
											type: this._org ?? OrganizationType.education
										);
										Fluttertoast.showToast(
											msg: 'Organização inserida com sucesso!'
										);
										Navigator.of(context).pushReplacementNamed('/home');
									}
								)
							]
						)
					)
				)
			)
		);
	}
}
