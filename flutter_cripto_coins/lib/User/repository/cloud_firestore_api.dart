import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cripto_coins/User/model/user.dart';
import 'package:flutter_cripto_coins/User/ui/widgets/profile_cryptocurrency.dart';
import 'package:flutter_cripto_coins/money/model/cryptocurrency.dart';


class CloudFirestoreAPI {

  final String USERS = "users";
  final String CRYPTOCURRENCIES = "cryptocurrencies";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(UserStore user) async {
    
    CollectionReference users = _db.collection(USERS);
    DocumentReference ref = users.doc(user.uid);
    
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'lastname': user.lastname,
      'email': user.email,
      'password': user.password,
      'country': user.country,
      'phoneOne': user.phoneOne,
      'phoneTwo': user.phoneTwo,
      'investment': user.investment,
      'gain': user.gain,
      'photoURL': user.photoURL,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));

  }

  Future<void> updateCryptocurrencyData(Cryptocurrency cryptocurrency) async {
    CollectionReference refCurrencies = _db.collection(CRYPTOCURRENCIES);

    User user = _auth.currentUser;
    await refCurrencies.add({
      'id': cryptocurrency.id,
      'name': cryptocurrency.name,
      'slug': cryptocurrency.slug,
      'sharesCount': cryptocurrency.sharesCount,
      'moneyInvested': cryptocurrency.moneyInvested,
      'price': cryptocurrency.price,
      'purchaseDate': cryptocurrency.purchaseDate,
      'percentChangeOneH': cryptocurrency.percentChangeOneH,
      'status': cryptocurrency.status,
      'userOwner': _db.doc("$USERS/${user.uid}"), //Reference
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        snapshot.id;
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          'myCryptoQuotes': FieldValue.arrayUnion(
              [_db.doc("$CRYPTOCURRENCIES/${snapshot.id}")])
        });
      });
    });
  }

  List<ProfileCryptocurrency> buildCruptocurrencies(
      List<DocumentSnapshot> cryptourrenciesListSnapshot) {
    List<ProfileCryptocurrency> profileCryptocurrency = [];
    cryptourrenciesListSnapshot.forEach((pc) {
      profileCryptocurrency.add(ProfileCryptocurrency(Cryptocurrency(
          price: pc['price'],
          purchaseDate: pc['purchaseDate'],
          name: pc['name'],
          id: pc['id'],
          slug: pc['slug'],
          sharesCount: pc['sharesCount'],
          moneyInvested: pc['moneyInvested'],
          percentChangeOneH: pc['percentChangeOneH'],
          status: pc['status'])));
    });

    return profileCryptocurrency;
  }


}