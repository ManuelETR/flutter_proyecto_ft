import 'package:flutter_proyecto_ft/data/models/installation_model.dart';
import 'package:flutter_proyecto_ft/data/models/order_model.dart';
import 'package:flutter_proyecto_ft/data/models/product_model.dart';
import 'package:flutter_proyecto_ft/domain/entities/installation.dart';
import 'package:flutter_proyecto_ft/domain/entities/order.dart';
import 'package:flutter_proyecto_ft/domain/repositories/installation_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstallationService implements InstallationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createInstallation(Installation installation) async {
    // Crear una nueva orden
    var orderRef = firestore.collection('orders').doc();
    var order = OrderModel.fromOrderC(OrderC(
      id: orderRef.id.hashCode, // Usar hashCode para generar un ID único
      friendlyId: 'ORD-${orderRef.id}',
      date: DateTime.now(),
      client: installation.order.client, frendlyId: '',
    ));
    await orderRef.set(order.toMap());

    // Crear una nueva instalación
    var installationRef = firestore.collection('installations').doc();
    var installationModel = InstallationModel(
      id: installationRef.id.hashCode, // Usar hashCode para generar un ID único
      order: order,
      product: installation.product as ProductModel,
      scheduleDate: installation.scheduleDate,
      completionDate: installation.completionDate,
      notes: installation.notes,
      status: installation.status,
    );
    await installationRef.set(installationModel.toMap());
  }

  @override
  Future<List<InstallationModel>> getInstallations() async {
    var querySnapshot = await firestore.collection('installations').get();
    var installations = await Future.wait(querySnapshot.docs.map((doc) => InstallationModel.fromFirestoreAsync(doc)).toList());
    return installations;
  }

  @override
  Future<void> updateInstallation(Installation installation) async {
    var installationRef = firestore.collection('installations').doc(installation.id.toString());
    await installationRef.update((installation as InstallationModel).toMap());
  }

  @override
  Future<void> deleteInstallation(int id) async {
    var installationRef = firestore.collection('installations').doc(id.toString());
    await installationRef.delete();
  }
}