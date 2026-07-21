# 🌱 ferme_ecoles

# Application Mobile Flutter

## Développement d’une Plateforme Web et Mobile d’Achat et Vente de Produits Agroécologiques et Biologiques

---

## 📌 Présentation du projet

**ferme_ecoles** est une application mobile développée avec **Flutter** dans le cadre du projet de développement d’une plateforme numérique pour la **FERME-ÉCOLE INTÉGRÉE** située à Ouagadougou, Burkina Faso.

Cette application permet aux utilisateurs de consulter les produits agroécologiques et biologiques, découvrir les producteurs, gérer leurs commandes et interagir avec les services proposés par la plateforme.

L’application communique avec une API REST développée avec **Django REST Framework** pour assurer la gestion des utilisateurs, des produits, des commandes, des paiements et des livraisons.

---

# 🚀 Fonctionnalités principales

## 👤 Authentification

- Création de compte utilisateur
- Connexion sécurisée avec JWT
- Gestion des sessions
- Gestion des profils
- Gestion des rôles :
  - Client
  - Producteur
  - Livreur
  - Administrateur

---

## 🌿 Catalogue des produits

- Consultation des produits agroécologiques et biologiques
- Recherche de produits
- Filtrage par catégorie
- Consultation des détails des produits
- Affichage des images
- Informations sur les producteurs

---

## 🛒 Panier et commandes

- Ajout des produits au panier
- Modification des quantités
- Suppression des articles
- Création de commandes
- Suivi des commandes
- Historique des achats

---

## 👨‍🌾 Espace producteur

- Consultation des produits
- Ajout de nouveaux produits
- Modification des produits
- Gestion du stock
- Suivi des statistiques

---

## 💬 Communauté

- Consultation du forum
- Création de discussions
- Réponses aux sujets
- Notifications

---

# 🛠️ Technologies utilisées

## Framework et langage

<p align="center">

<img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/flutter/flutter-original.svg" width="70"/>

<img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/dart/dart-original.svg" width="70"/>

</p>


<p align="center">

<img src="https://img.shields.io/badge/Flutter-Framework-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>

<img src="https://img.shields.io/badge/Dart-Language-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>

</p>


## Packages principaux

<p align="center">

<img src="https://img.shields.io/badge/Provider-State_Management-2196F3?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Dio-HTTP_Client-black?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Go_Router-Navigation-orange?style=for-the-badge"/>

<img src="https://img.shields.io/badge/Secure_Storage-Token_Security-green?style=for-the-badge"/>

</p>


## Outils de développement

<p align="center">

<img src="https://img.shields.io/badge/Android_Studio-IDE-3DDC84?style=for-the-badge&logo=androidstudio&logoColor=white"/>

<img src="https://img.shields.io/badge/Visual_Studio_Code-Editor-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white"/>

<img src="https://img.shields.io/badge/Git-Version_Control-F05032?style=for-the-badge&logo=git&logoColor=white"/>

<img src="https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github&logoColor=white"/>

</p>

---

# 📂 Structure du projet

```
lib/
│
├── core/
│   ├── constants/
│   ├── routes/
│   ├── theme/
│   └── utils/
│
├── models/
│   ├── produit_model.dart
│   ├── commande_model.dart
│   ├── categorie_model.dart
│   └── utilisateur_model.dart
│
├── services/
│   ├── api_service.dart
│   ├── auth_service.dart
│   ├── catalog_service.dart
│   ├── commande_service.dart
│   └── paiement_service.dart
│
├── providers/
│   ├── auth_provider.dart
│   ├── produit_provider.dart
│   ├── panier_provider.dart
│   └── commande_provider.dart
│
├── screens/
│   ├── auth/
│   ├── public/
│   ├── client/
│   ├── producteur/
│   └── shared/
│
├── widgets/
│
└── main.dart
```

---

# ⚙️ Installation

## Prérequis

- Flutter SDK
- Dart SDK
- Android Studio ou Visual Studio Code
- Un émulateur Android ou un appareil physique


## Installation des dépendances

```bash
flutter pub get
```


## Configuration de l’API

Modifier l’adresse du serveur dans :

```
lib/core/constants/api_constants.dart
```

Exemple :

```dart
static const String baseUrl =
    "http://127.0.0.1:8000/api";
```


---

# ▶️ Lancement de l’application

Vérifier les appareils disponibles :

```bash
flutter devices
```


Lancer l’application :

```bash
flutter run
```


Lancer sur Chrome :

```bash
flutter run -d chrome
```

---

# 📚 Ressources Flutter

- [Documentation Flutter](https://docs.flutter.dev/)
- [Apprendre Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Premier projet Flutter](https://docs.flutter.dev/get-started/codelab)

---

# 👨‍🎓 Auteur

**Moussa Kassongo**

Projet réalisé dans le cadre d’un mémoire de licence :

**Développement d’une Plateforme Web et Mobile d’Achat et Vente de Produits Agroécologiques et Biologiques**

FERME-ÉCOLE INTÉGRÉE  
Ouagadougou, Burkina Faso

---

# 📄 Licence

Projet développé à des fins académiques.