# Documentation Technique - Hotel

Application Flutter de réservation d'hôtel.

## Vue d'ensemble du projet

L'application permet de :

- parcourir une liste d'hôtels
- rechercher un hôtel par lieu ou par nom
- ajouter et supprimer des favoris
- sélectionner des dates et effectuer une réservation
- consulter l'historique des réservations

## Technologies utilisées

- `Flutter` pour l'interface utilisateur
- `GetX` pour la navigation et le state management
- `ObjectBox` pour la base de données locale
- `Provider` pour la lecture des hôtels

## Structure du projet

```text
lib/
├── controllers/
├── data/
├── models/
├── pages/
├── services/
├── widgets/
├── main.dart
└── main_layout.dart
```

## Défi n°1 : amélioration de la recherche

### Objectif pédagogique

- comprendre les `StatefulWidget`
- utiliser un `TextEditingController` et le libérer dans `dispose()`
- filtrer une liste avec `where()` et `contains()`
- naviguer en passant des données entre écrans

### Réalisations

- création d'un écran `SearchResultsPage`
- récupération de la requête de l'utilisateur
- filtrage de la liste des hôtels sur `title` ou `place`
- affichage du résultat avec `HotelCard`
- transformation de `SearchSection` en `StatefulWidget`
- lecture du texte dans le `onPressed` du bouton de recherche
- navigation vers `SearchResultsPage`
- gestion du cas sans résultat avec message et icône

### Extrait de code significatif

```dart
class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Get.to(() => SearchResultsPage(searchQuery: query));
    }
  }
}
```

### Compétences acquises

- cycle de vie d'un état avec `dispose()`
- récupération de la saisie utilisateur
- filtrage de listes dynamiques
- navigation paramétrée

## Défi n°2 : fonctionnalité Favoris avec Provider

### Objectif pédagogique

- gérer un état partagé avec `ChangeNotifier` et `Provider`
- ajouter et supprimer des éléments d'une `Set`
- rendre l'interface réactive avec `notifyListeners()`

### Réalisations

- création d'un `FavoritesProvider`
- utilisation de `Set<int> _favoriteIds` pour éviter les doublons
- implémentation de `toggleFavorite(int hotelId)`
- modification de `HotelCard`
- le bouton coeur appelle `toggleFavorite`
- l'icône change selon `isFavorite`
- création d'une page `FavoritesPage`
- affichage d'un message si aucun favori n'existe

### Extrait de code significatif

```dart
class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};

  void toggleFavorite(int hotelId) {
    if (_favoriteIds.contains(hotelId)) {
      _favoriteIds.remove(hotelId);
    } else {
      _favoriteIds.add(hotelId);
    }
    notifyListeners();
  }

  bool isFavorite(int hotelId) => _favoriteIds.contains(hotelId);
}
```

### Compétences acquises

- utilisation de `ChangeNotifier`
- rafraîchissement d'interface avec `notifyListeners()`
- gestion d'état global simple
- manipulation de `Set`

## Défi n°3 : migration vers GetX

### Objectif pédagogique

- découvrir `GetX` : `GetMaterialApp`, `Obx`, `Get.find()`, `Get.put()`
- remplacer `Navigator.push` par `Get.to()`
- convertir la gestion des favoris avec un `GetxController`

### Réalisations

- remplacement de `MaterialApp` par `GetMaterialApp`
- mise à jour de `main.dart`
- création de `FavoritesController`
- utilisation de `var favoriteHotels = <Hotel>[].obs`
- implémentation de `toggleFavorite` et `isFavorite`
- suppression du besoin d'appeler `notifyListeners()` manuellement
- mise à jour de `HotelCard` avec `Obx(() => ...)`
- récupération du contrôleur avec `Get.find<FavoritesController>()`
- navigation avec `Get.to()` et `Get.back()`

### Extrait de code significatif

```dart
class FavoritesController extends GetxController {
  var favoriteHotels = <Hotel>[].obs;

  void toggleFavorite(Hotel hotel) {
    if (favoriteHotels.contains(hotel)) {
      favoriteHotels.remove(hotel);
    } else {
      favoriteHotels.add(hotel);
    }
  }

  bool isFavorite(Hotel hotel) => favoriteHotels.contains(hotel);
}
```

### Compétences acquises

- injection de dépendances avec `GetX`
- état réactif avec `.obs` et `Obx`
- navigation context-free
- meilleure maintenabilité du code

## Défi n°4 : persistance avec ObjectBox

### Objectif pédagogique

- installer et configurer `ObjectBox`
- définir des entités avec `@Entity` et `@Id`
- générer le code avec `build_runner`
- implémenter le CRUD : sauvegarder, lire, supprimer

### Réalisations

- ajout des dépendances `objectbox`, `objectbox_flutter_libs`, `objectbox_generator`
- création des entités `FavoriteEntity` et `BookingEntity`
- création du service `ObjectBoxService`
- initialisation avec `getApplicationDocumentsDirectory()`
- ajout des méthodes `toggleFavorite(int hotelId)`, `getFavoriteIds()`
- ajout des méthodes `addBooking(BookingEntity)`, `getAllBookings()`
- adaptation de `FavoritesController`
- chargement des IDs favoris au démarrage
- reconstruction de la liste des hôtels favoris
- création de `MyBookingsPage`
- affichage des réservations triées par date
- enregistrement d'une réservation lors du clic sur `PAYER`

### Extraits de code significatifs

```dart
@Entity()
class FavoriteEntity {
  @Id()
  int id = 0;
  int hotelId;

  FavoriteEntity({this.id = 0, required this.hotelId});
}
```

```dart
Future<void> toggleFavorite(int hotelId) async {
  final existing = _favoriteBox
      .query(FavoriteEntity_.hotelId.equals(hotelId))
      .build()
      .findFirst();

  if (existing != null) {
    _favoriteBox.remove(existing.id);
  } else {
    _favoriteBox.put(FavoriteEntity(hotelId: hotelId));
  }
}
```

### Compétences acquises

- persistance locale performante avec `ObjectBox`
- génération de code avec `build_runner`
- requêtes simples avec `Box`
- gestion de l'initialisation asynchrone dans `main()`

## Difficultés surmontées

- conflits de versions entre Dart `3.10` et ObjectBox `5.x`
- stabilisation avec la version `5.3.1`
- erreur avec `dart run build_runner`
- utilisation de `flutter pub run build_runner` à la place

## Tableau récapitulatif des compétences par défi

| Défi | Compétences clés | Technologies |
|------|------------------|--------------|
| 1 | `TextEditingController`, `dispose`, filtrage, navigation paramétrée | Flutter |
| 2 | `ChangeNotifier`, `Provider`, `Set`, état global simple | Provider |
| 3 | `GetMaterialApp`, `Obx`, `Get.find()`, navigation context-free | GetX |
| 4 | `ObjectBox`, annotations, `build_runner`, CRUD, persistance | ObjectBox + GetX |

## Commandes utiles

### Générer automatiquement le code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Nettoyer le projet Flutter

```bash
flutter clean
```

### Nettoyer les fichiers Dart temporaires

```bash
rm -rf .dart_tool
```

### Supprimer le verrouillage des versions

```bash
rm pubspec.lock
```

### Télécharger toutes les dépendances

```bash
flutter pub get
```

### Lancer l'application

```bash
flutter run
```

## Installation rapide

```bash
git clone <url-du-repo>
cd hotel
flutter pub get
flutter run
```

## Remarque

Selon la configuration Flutter/Dart de la machine, la génération automatique d'ObjectBox peut nécessiter un ajustement supplémentaire.
# HOTEL-FLUTTER
