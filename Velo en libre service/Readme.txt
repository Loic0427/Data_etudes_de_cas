# 🚴 Case Study Data Analytics: Cyclistic (Vélo en libre-service)

## 📌 Présentation du projet
Ce projet est une étude de cas pratique réalisée dans le cadre de ma formation de **Data Analyst**. L'objectif est d'analyser les données historiques des trajets de l'entreprise **Cyclistic**, un service de vélos en libre-service, afin de comprendre comment les clients réguliers (*membres*) et les clients occasionnels (*casual*) utilisent le service différemment. 

L'enjeu stratégique final est de concevoir des recommandations pour **convertir les utilisateurs occasionnels en abonnés annuels**, d'optimiser la flotte de vélos (classiques vs électriques) et d'identifier les stations clés du réseau.

---

## 🎯 Problématiques à résoudre
1. **Comprendre les habitudes :** Comment les membres et les utilisateurs occasionnels utilisent-ils les vélos (durée, jours de la semaine, types de vélos) ?
2. **Convertir l'occasionnel :** Pourquoi les clients occasionnels devraient-ils souscrire un abonnement ?
3. **Optimisation logistique :** Sur quelles stations et quels types de vélos (classiques ou électriques) faut-il concentrer les investissements selon la demande ?

---

## 💾 Les Données (Dataset)
La base de données d'origine est composée de fichiers CSV contenant l'historique des trajets.
* **Période analysée :** Du 01-2025 au 12-2025 (12 feuilles mensuelles).
* **Données incluses :** Type de vélo (`rideable_type`), horodatage de départ et d'arrivée (`started_at`, `ended_at`), ID et noms des stations de départ/arrivée, et type d'utilisateur (`member_casual`).
* **Hypothèse de départ :** La base de données source est considérée comme sécurisée, intègre et accessible.

---

## 🛠️ Processus de Nettoyage et Préparation des Données (Excel)

> **Note technique :** Par souci de performance et pour éviter le plantage de l'application Excel lors de l'insertion de formules complexes, les données des années 2023 et 2024 ont été retirées pour se concentrer exclusivement sur l'année complète 2025.

### Étape 1 : Nettoyage des 12 feuilles mensuelles (01-2025 à 12-2025)
* **Suppression des colonnes non critiques :** Retrait de `ride_id` (ID de location) ainsi que des coordonnées GPS (`start_lat`, `start_lng`, `end_lat`, `end_lng`) pour alléger le fichier.
* **Traitement des données manquantes :** Application de filtres sur l'ensemble des colonnes restantes pour isoler, analyser et **supprimer les lignes contenant des valeurs vides/manquantes** (notamment sur les noms de stations).
* **Création de variables de calcul :**
  * `ride_length` : Calcul de la durée de chaque trajet (`= ended_at - started_at`).
  * `day_of_week` : Extraction du jour de la semaine sous forme numérique (1 = Lundi, 7 = Dimanche) basé sur la colonne `started_at`.

### Étape 2 : Analyse et Agrégation Mensuelle
Utilisation de formules matricielles et statistiques pour segmenter les comportements par mois :
* **Durées moyennes de trajet :** Calculs croisés selon le type de vélo et le profil utilisateur via `=MOYENNE.SI.ENS()`.
* **Volumes de location :** Comptabilisation précise des trajets via `=NB.SI.ENS()` pour croiser le statut utilisateur (*member* / *casual*) et le matériel utilisé (*electric_bike* / *classic_bike*).
* **Saisonnalité et préférences :** Identification du jour de la semaine le plus fréquenté par catégorie à l'aide de formules combinées :
```excel
  =MODE(SI((A:A="electric_bike")*(G:G="member");D:D))