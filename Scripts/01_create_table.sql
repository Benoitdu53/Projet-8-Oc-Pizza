
CREATE SEQUENCE public.restaurant_id_seq;

CREATE TABLE public.Restaurant (
                id INTEGER NOT NULL DEFAULT nextval('public.restaurant_id_seq'),
                nom VARCHAR(32) NOT NULL,
                ville VARCHAR(100) NOT NULL,
                NumSiret VARCHAR(100) NOT NULL,
                telephone VARCHAR(15) NOT NULL,
                CONSTRAINT restaurant_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.restaurant_id_seq OWNED BY public.Restaurant.id;

CREATE SEQUENCE public.ingredient_id_ingredient_seq;

CREATE TABLE public.Ingredient (
                id INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_ingredient_seq'),
                nom VARCHAR(32) NOT NULL,
                unite VARCHAR(5) NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingredient_id_ingredient_seq OWNED BY public.Ingredient.id;

CREATE TABLE public.IngredientRestaurant (
                idRestaurant INTEGER NOT NULL,
                idIngredient INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ingredientrestaurant_pk PRIMARY KEY (idRestaurant, idIngredient)
);


CREATE SEQUENCE public.employe_id_employe_seq_1;

CREATE TABLE public.Employe (
                id INTEGER NOT NULL DEFAULT nextval('public.employe_id_employe_seq_1'),
                matricule VARCHAR(5) NOT NULL,
                nom VARCHAR(32) NOT NULL,
                prenom VARCHAR(32) NOT NULL,
                motDePasse VARCHAR(32) NOT NULL,
                typeEmploye VARCHAR(16) NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.employe_id_employe_seq_1 OWNED BY public.Employe.id;

CREATE SEQUENCE public.pizza_id_pizza_seq;

CREATE TABLE public.Pizza (
                id INTEGER NOT NULL DEFAULT nextval('public.pizza_id_pizza_seq'),
                nomPizza VARCHAR NOT NULL,
                disponibilite BOOLEAN NOT NULL,
                prix DOUBLE PRECISION NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT id_pizza PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizza_id_pizza_seq OWNED BY public.Pizza.id;

CREATE TABLE public.IngredientPizza (
                idPizza INTEGER NOT NULL,
                idIngredient INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ingredientpizza_pk PRIMARY KEY (idPizza, idIngredient)
);


CREATE SEQUENCE public.recette_id_recette_seq;

CREATE TABLE public.Recette (
                id INTEGER NOT NULL DEFAULT nextval('public.recette_id_recette_seq'),
                idPizza INTEGER NOT NULL,
                procede VARCHAR(1000) NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT recette_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.recette_id_recette_seq OWNED BY public.Recette.id;

CREATE SEQUENCE public.client_id_client_seq;

CREATE TABLE public.Client (
                id INTEGER NOT NULL DEFAULT nextval('public.client_id_client_seq'),
                nom VARCHAR NOT NULL,
                prenom VARCHAR NOT NULL,
                motDePasse VARCHAR(32) NOT NULL,
                mail VARCHAR(64) NOT NULL,
                telephone VARCHAR(15) NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT id_client PRIMARY KEY (id)
);


ALTER SEQUENCE public.client_id_client_seq OWNED BY public.Client.id;

CREATE SEQUENCE public.adresse_id_seq;

CREATE TABLE public.Adresse (
                id INTEGER NOT NULL DEFAULT nextval('public.adresse_id_seq'),
                idClient INTEGER NOT NULL,
                numVoie INTEGER NOT NULL,
                typeVoie VARCHAR(32) NOT NULL,
                nomVoie VARCHAR(100) NOT NULL,
                codePostale VARCHAR(5) NOT NULL,
                ville VARCHAR(100) NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adresse_id_seq OWNED BY public.Adresse.id;

CREATE TABLE public.Commande (
                id INTEGER NOT NULL,
                idRestaurant INTEGER NOT NULL,
                idClient INTEGER NOT NULL,
                idPreparateur INTEGER NOT NULL,
                idAdresse INTEGER NOT NULL,
                idLivreur INTEGER,
                date TIMESTAMP NOT NULL,
                statut VARCHAR(50) NOT NULL,
                paiementEnLigne BOOLEAN NOT NULL,
                heureLivraisonPrevue TIMESTAMP NOT NULL,
                livraison BOOLEAN NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id)
);


CREATE SEQUENCE public.temps_id_temps_seq;

CREATE TABLE public.Temps (
                id INTEGER NOT NULL DEFAULT nextval('public.temps_id_temps_seq'),
                idCommande INTEGER NOT NULL,
                tempsPreparation TIME NOT NULL,
                tempsLivraison TIME NOT NULL,
                CONSTRAINT temps_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.temps_id_temps_seq OWNED BY public.Temps.id;

CREATE TABLE public.LigneCommande (
                idPizza INTEGER NOT NULL,
                idCommande INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT lignecommande_pk PRIMARY KEY (idPizza, idCommande)
);


CREATE SEQUENCE public.facture_id_facture_seq;

CREATE TABLE public.Facture (
                id INTEGER NOT NULL DEFAULT nextval('public.facture_id_facture_seq'),
                idCommande INTEGER NOT NULL,
                numFacture VARCHAR(32) NOT NULL,
                prixHt DOUBLE PRECISION NOT NULL,
                modePaiement VARCHAR(32) NOT NULL,
                TVA INTEGER DEFAULT 10 NOT NULL,
                prixTTC DOUBLE PRECISION NOT NULL,
                createDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                createUser VARCHAR(100) NOT NULL,
                updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
                updateUser VARCHAR(100) NOT NULL,
                CONSTRAINT facture_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.facture_id_facture_seq OWNED BY public.Facture.id;

ALTER TABLE public.Commande ADD CONSTRAINT restaurant_commande_fk
FOREIGN KEY (idRestaurant)
REFERENCES public.Restaurant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.IngredientRestaurant ADD CONSTRAINT restaurant_ingredientrestaurant_fk
FOREIGN KEY (idRestaurant)
REFERENCES public.Restaurant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.IngredientPizza ADD CONSTRAINT ingredient_ingredientpizza_fk
FOREIGN KEY (idIngredient)
REFERENCES public.Ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.IngredientRestaurant ADD CONSTRAINT ingredient_ingredientrestaurant_fk
FOREIGN KEY (idIngredient)
REFERENCES public.Ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT employe_commande_fk
FOREIGN KEY (idPreparateur)
REFERENCES public.Employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (idPizza)
REFERENCES public.Pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.IngredientPizza ADD CONSTRAINT pizza_ingredientpizza_fk
FOREIGN KEY (idPizza)
REFERENCES public.Pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.LigneCommande ADD CONSTRAINT pizza_lignecommande_fk
FOREIGN KEY (idPizza)
REFERENCES public.Pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (idClient)
REFERENCES public.Client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Adresse ADD CONSTRAINT client_adresselivraison_fk
FOREIGN KEY (idClient)
REFERENCES public.Client (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT adresse_commande_fk
FOREIGN KEY (idAdresse)
REFERENCES public.Adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (idCommande)
REFERENCES public.Commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.LigneCommande ADD CONSTRAINT commande_lignecommande_fk
FOREIGN KEY (idCommande)
REFERENCES public.Commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Temps ADD CONSTRAINT commande_temps_fk
FOREIGN KEY (idCommande)
REFERENCES public.Commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
