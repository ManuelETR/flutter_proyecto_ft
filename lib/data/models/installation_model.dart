import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_proyecto_ft/domain/entities/statusType.dart';

class InstallationModel extends Installation {
  InstallationModel({
    required super.id,
    required OrderModel order,
    required ProductModel product,
    required super.scheduleDate,
    super.completionDate,
    super.notes,
    required super.status,
  }) : super(
          order: order.toOrderC(),
          product: product.toProduct(),
        );

  factory InstallationModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return InstallationModel(
      id: data['id'],
      order: OrderModel.fromFirestore(data['order']),
      product: ProductModel.fromFirestore(data['product']),
      scheduleDate: (data['scheduleDate'] as Timestamp).toDate(),
      completionDate: (data['completionDate'] as Timestamp?)?.toDate(),
      notes: data['notes'],
      status: StatusType.values.firstWhere((e) => e.toString() == data['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': (order is OrderModel) ? (order as OrderModel).toMap() : OrderModel.fromOrderC(order).toMap(),
      'product': (product is ProductModel) ? (product as ProductModel).toMap() : ProductModel.fromProduct(product).toMap(),
      'scheduleDate': scheduleDate.toIso8601String(),
      'completionDate': completionDate?.toIso8601String(),
      'notes': notes,
      'status': status.toString(),
    };
  }

  factory InstallationModel.fromInstallation(Installation installation) {
    return InstallationModel(
      id: installation.id,
      order: OrderModel.fromOrderC(installation.order),
      product: ProductModel.fromProduct(installation.product),
      scheduleDate: installation.scheduleDate,
      completionDate: installation.completionDate,
      notes: installation.notes,
      status: installation.status,
    );
  }

  String get friendlyId => id.toString();
  String get name => "Installation $id";
  String get description => notes ?? "No description available";

  Installation toInstallation() {
    return Installation(
      id: id,
      order: order,
      product: product,
      scheduleDate: scheduleDate,
      completionDate: completionDate,
      notes: notes,
      status: status,
    );
  }
}
