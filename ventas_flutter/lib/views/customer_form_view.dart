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
  final _nameController = TextEditingController();
  final _rucController = TextEditingController();
  final _addressController = TextEditingController();
  final Uuid _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _nameController.text = widget.customer!.name;
      _rucController.text = widget.customer!.ruc;
      _addressController.text = widget.customer!.address;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rucController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      final id = widget.customer?.id ?? _uuid.v4();
      final name = _nameController.text;
      final ruc = _rucController.text;
      final address = _addressController.text;

      final customer = Customer(id: id, name: name, ruc: ruc, address: address);
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
      appBar: AppBar(
        title: Text(widget.customer == null ? 'New Customer' : 'Edit Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rucController,
                decoration: InputDecoration(labelText: 'Customer RUC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer RUC';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Customer Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveCustomer,
                child: Text('Save Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


