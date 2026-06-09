# Étude de Cas Data Analytics : CYCLISTIC (Vélo en Libre-Service)

## Présentation du projet
Ce projet est une étude de cas pratique réalisée dans le cadre de ma formation de **Data Analyst**. L'objectif est d'analyser les données historiques des trajets de l'entreprise **Cyclistic** afin de comprendre comment les clients réguliers (*membres*) et les clients occasionnels (*casual*) utilisent le service différemment. 

L'enjeu stratégique final est de fournir des insights basés sur la donnée pour **convertir les utilisateurs occasionnels en abonnés**, optimiser la gestion de la flotte et cibler les investissements selon la demande réelle.

---

## Problématiques et Objectifs
* **Énoncé clair :** Comprendre les habitudes des clients et la fréquentation des stations, pour offrir la meilleure gamme de service (vélo électrique ou classique).
* **Conversion :** Identifier les leviers pour faire passer les clients du statut *occasionnel* à l'un des formats d'*abonnement*.
* **Ciblage géographique :** Miser sur les emplacements et les stations les plus demandés.
* **Gestion de flotte :** Investir stratégiquement dans les vélos classiques ou électriques selon l'évolution de la demande.

---

## Présentation des Données (Dataset)
* **Format source :** Base de données organisée en 12 fichiers/feuilles représentant les 12 mois de l'année (**de 01-2025 à 12-2025**).
* **Variables incluses :** ID du trajet, type de vélo (`rideable_type`), date/heure de départ (`started_at`), date/heure d'arrivée (`ended_at`), ID et nom de la station de départ (`start_station_name`), ID et nom de la station d'arrivée (`end_station_name`), et statut du client (`member_casual`).
* **Postulat de départ :** La base de données initiale est stockée, sécurisée et accessible de manière optimale.

---

## Processus de Nettoyage et Préparation des Données

>  **Note sur la performance système :** Par souci de fluidité et pour éviter le ralentissement ou le plantage de l'application Excel lors de l'application de formules complexes, les données des années 2023 et 2024 ont été retirées du périmètre pour concentrer l'analyse exclusivement sur l'année complète 2025.

### 1. Nettoyage des 12 feuilles mensuelles (`01-2025` à `12-2025`)
* **Réduction de dimension :** Suppression des colonnes non indispensables pour notre étude afin d'alléger les calculs : ID de la location (`ride_id`), coordonnées GPS de départ (`start_lat`, `start_lng`) et d'arrivée (`end_lat`, `end_lng`).
* **Traitement des données manquantes ou erronées :** Application de filtres sur l'ensemble des colonnes (`rideable_type`, `started_at`, `ended_at`, `start_station_name`, `end_station_name`, `member_casual`) pour isoler les lignes vides/incomplètes et les supprimer définitivement.
* **Création de nouvelles variables (Feature Engineering) :**
  * **Calcul de la durée de trajet (`ride_length`) :** `=ended_at - started_at` (formaté en temps pour obtenir la durée moyenne).
  * **Calcul du jour de la semaine (`day_of_week`) :** Extraction du jour sous forme numérique (1 = Lundi, 7 = Dimanche) basé sur la date de départ : `=JOURSEM(started_at;2)`

### 2. Calculs Statistiques Mensuels et Segmentés
Pour chaque mois, des formules avancées ont été appliquées pour diviser les comportements des utilisateurs :

* **Durées moyennes de trajet (en minutes/heures) :**
  * Occasionnels en Vélo Électrique : `=MOYENNE.SI.ENS(G:G; A:A; "electric_bike"; F:F; "casual")`
  * Occasionnels en Vélo Classique : `=MOYENNE.SI.ENS(G:G; A:A; "classic_bike"; F:F; "casual")`
  * Membres en Vélo Électrique : `=MOYENNE.SI.ENS(G:G; A:A; "electric_bike"; F:F; "member")`
  * Membres en Vélo Classique : `=MOYENNE.SI.ENS(G:G; A:A; "classic_bike"; F:F; "member")`

* **Total du nombre de locations (Volumes) :**
  * Membres / Vélos Électriques : `=NB.SI.ENS(F:F; "member"; A:A; "electric_bike")`
  * Occasionnels / Vélos Électriques : `=NB.SI.ENS(F:F; "casual"; A:A; "electric_bike")`
  * Occasionnels / Vélos Classiques : `=NB.SI.ENS(F:F; "casual"; A:A; "classic_bike")`
  * Membres / Vélos Classiques : `=NB.SI.ENS(F:F; "member"; A:A; "classic_bike")`

* **Jours de la semaine préférés (Formules Matricielles `MODE`) :**
  * Membres (Électrique) : `=MODE(SI((A:A="electric_bike")*(G:G="member");D:D))`
  * Membres (Classique) : `=MODE(SI((A:A="classic_bike")*(G:G="member");D:D))`
  * Occasionnels (Électrique) : `=MODE(SI((A:A="electric_bike")*(G:G="casual");D:D))`
  * Occasionnels (Classique) : `=MODE(SI((A:A="classic_bike")*(G:G="casual");D:D))`

---

## Architecture du Classeur Excel et Traitement Global

### Onglet `Tableau_mensuel_detaillé`
Cet onglet compile la liste unique de toutes les stations (Colonne A) et effectue une analyse de flux spécifique pour les mois de **haute saison (Juin, Juillet, Août, Septembre)** via 3 indicateurs clés :
* **Total Retraits (TR) :** Nombre de départs depuis la station. Exemple : `=NB.SI('06-2025'!E:E;A2)`
* **Total Dépôts (TD) :** Nombre d'arrivées à la station. Exemple : `=NB.SI('06-2025'!F:F;A2)`
* **Flux net (TD - TR) :** Différence numérique pour savoir si la station se vide ou déborde.

### Onglet `TCD_total_entrées`
Création d'un **Tableau Croisé Dynamique (TCD)** global pour synthétiser l'activité de chaque station :
* **Colonnes :** `name_stations`, `somme_dépôt`, `somme_retraits`, `somme_différence_d/r`.
* **Traitement :** Tri automatique de la différence dépôts/retraits du plus petit au plus grand et application de filtres avancés pour masquer les données non pertinentes.

### Onglet `Classement_stations_06_07_08_09`
À partir des filtres appliqués sur le TCD précédent, cet onglet isole les points critiques du réseau pour les mois d'été :
* Le **Top 10 des Stations Excédentaires** (+ de dépôts que de retraits).
* Le **Top 10 des Stations Déficitaires** (- de dépôts que de retraits).
* Toutes les données sont rigoureusement segmentées et triées par mois.

### Onglet `Monthly Summary` (Tableau de bord de synthèse annuelle)
Tableau récapitulatif annuel croisant les données macroéconomiques de l'activité 2025 :
* **Indicateurs de Flotte :** Moyenne mensuelle des locations de vélos électriques (`avg_elec_bike` via `=MOYENNE('01-2025:12-2025'!L5)`) et classiques (`avg_classic_bike`).
* **Parts de marché (en %) :** Répartition des locations par type de vélo (`% classic`, `% electrique`) et par segment client (ex: `Casual_elec`, `member_elec`, `member_classic`, `casual_classic`).
* **Volume Global de l'année :** Calculé avec la formule `=SOMME(G2;H2;I2;J2)`.
* **Analyse Temporelle Transversale :** Une matrice organisée avec les mois en colonnes et les profils en lignes, utilisant la fonction `=MODE()` sur l'ensemble des 12 feuilles pour déterminer le jour exact de la semaine le plus performant à l'année.

---

## Livrables et Présentation des Résultats

Les conclusions de cette analyse de données, ainsi que les recommandations stratégiques marketing qui en découlent, ont été formalisées dans un support de présentation dédié.

* **Support de présentation :** `Etude_de_cas_Cyclistic.pptx`
* **Accès en ligne :** Le livrable complet et interactif est disponible à l'adresse suivante : [Lien vers la présentation Canva](https://canva.link/2zwoz5xchezgs4q)

Cette présentation regroupe l'ensemble des graphiques d'aide à la décision (croissance des volumes, impact de la saisonnalité et cartographie logistique des flux de stations).

---

## Compétences Data démontrées dans ce projet
* **Data Cleaning & Manipulation :** Traitement de gros volumes de données découpées mensuellement, élimination des valeurs aberrantes et des lignes incomplètes sous Excel.
* **Feature Engineering :** Création et modélisation de nouvelles métriques à partir de variables brutes (`ride_length`, `day_of_week`).
* **Analyse Statistique & Requêtage Avancé :** Maîtrise avancée des formules logiques imbriquées (`NB.SI.ENS`, `MOYENNE.SI.ENS`), des formules matricielles (`MODE(SI())`) et des Tableaux Croisés Dynamiques (TCD).
* **Data Visualization & Storytelling :** Préparation de tables de synthèse prêtes pour la mise en graphique et vulgarisation des insights sous forme de pitch d'affaires.