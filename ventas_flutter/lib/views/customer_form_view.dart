import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../controllers/customer_controller.dart';
import '../models/customer.dart';

class CustomerFormView extends StatefulWidget {
  final Customer? customer;

  CustomerFormView({this.customer});

  @override
  _CustomerFormViewState createState() => _CustomerFormViewState();
}

class _CustomerFormViewState extends State<CustomerFormView> {
  final CustomerController _customerController = CustomerController();
  final _formKey = GlobalKey<FormState>();
  final Uuid _uuid = Uuid();
  late String _name;
  late String _ruc;
  late String _address;

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _name = widget.customer!.name;
      _ruc = widget.customer!.ruc;
      _address = widget.customer!.address;
    } else {
      _name = '';
      _ruc = '';
      _address = '';
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final customer = Customer(
        id: widget.customer?.id ?? _uuid.v4(), // Generar un ID único si es un nuevo cliente
        name: _name,
        ruc: _ruc,
        address: _address,
      );
      if (widget.customer == null) {
        _customerController.addCustomer(customer);
      } else {
        _customerController.updateCustomer(customer);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _ruc,
                decoration: InputDecoration(labelText: 'RUC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a RUC';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ruc = value!;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

