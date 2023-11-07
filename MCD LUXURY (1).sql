CREATE TABLE Utilisateur (
    id_user INT AUTO_INCREMENT,
    login varchar(25) NOT NULL UNIQUE,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    prenom VARCHAR(255) NOT NULL,
    mdp VARCHAR(255) NOT NULL UNIQUE,
    constraint pk_utilisateur PRIMARY KEY (id_user),
    Engine=InnoDB,
    ON DELETE CASCADE,
    ON UPDATE CASCADE
);

CREATE TABLE Client (
    id_user INT PRIMARY KEY NOT NULL,
    telephone VARCHAR(20) NOT NULL UNIQUE,
    adresse VARCHAR(255),
   constraint fk_client FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user),
   constraint pk_client PRIMARY KEY (id_user),
    Engine=InnoDB,
    ON DELETE CASCADE,
    ON UPDATE CASCADE

);

CREATE TABLE Services (
    service_id INT AUTO_INCREMENT,
    nom varchar(50) NOT NULL,
    prix FLOAT NOT NULL,
    date_prestation DATE NOT NULL,
    constraint pk_services PRIMARY KEY (service_id),
    constraint pk_services_prest PRIMARY KEY(date_prestation),
    Engine=InnoDB,
    ON DELETE CASCADE,
    ON UPDATE CASCADE
);



CREATE TABLE Propriete (
    ref_propriete INT AUTO_INCREMENT,
    nom VARCHAR(255),
    description TEXT,
    ville VARCHAR(255),
    pays VARCHAR(255),
    nombreChambres INT,
    nombrePersonnes INT,
    prixNuit DECIMAL(10, 2),
    date_arrivée DATE,
    date_départ DATE,
    disponibilite BOOLEAN,

);

CREATE TABLE Proprietaire (
   id_user INT PRIMARY KEY,
   ref_propriete INT,
    constraint fk_prop_id FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user),
    constraint fk_prop_refpropriete FOREIGN KEY (ref_propriete) REFERENCES Propriete(ref_propriete),
    constraint pk_proprietaire PRIMARY KEY (id_user),
    Engine=InnoDB,
    ON DELETE CASCADE,
    ON UPDATE CASCADE
);

CREATE TABLE Reservation (
    num_reserv INT PRIMARY KEY,
    id_user INT,
    service_id INT,
   ref_propriete INT,
    nombre_p INT NOT NULL,
    duree_res INT NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
   id_user INT,
    montant_total DECIMAL(10, 2) NOT NULL,
  constraint  fk_reser_id_user FOREIGN KEY (id_user) REFERENCES Client(id_user),
   constraint fk_reserv_prop FOREIGN KEY (ref_propriete) REFERENCES Propriete(ref_propriete),
  constraint  fk_reserv_services FOREIGN KEY (service_id) REFERENCES Services(service_id),
);

CREATE TABLE Contrat_Location (
    ref_contrat INT PRIMARY KEY,
   date_debut DATE NOT NULL,
    date_fin DATE   NOT NULL,
    duree_contrat INT   NOT NULL, 
    etat_contrat ENUM ('ACTIF','INACTIF') NOT NULL,
    ref_propriete INT,
   id_user INT,
   constraint FOREIGN KEY fk_loc_iduser (id_user) REFERENCES Proprietaire(id_user),
    constraint FOREIGN KEY fk_loc_refprop (ref_propriete) REFERENCES Propriete(ref_propriete),
    constraint pk_contrat PRIMARY KEY (ref_contrat),
    Engine=InnoDB,  
    ON DELETE CASCADE,
    ON UPDATE CASCADE
);

CREATE TABLE Contrat_Cautionnement (
    ref_caution INT PRIMARY KEY,
   date_debut DATE,
    date_fin DATE,
    duree_contrat INT,
    etat_contrat ENUM ('EN COURS','TERMINEE'),
    montant FLOAT NOT NULL,
    ref_propriete INT,
   id_user INT,
   num_reserv INT,
   constraint FOREIGN KEY fk_caut_numreserv (num_reserv) REFERENCES Reservation(num_reserv),
   constraint FOREIGN KEY fk_caut_iduser (id_user) REFERENCES Client(id_user),
    constraint FOREIGN KEY fk_caut_refprop (ref_propriete) REFERENCES Propriete(ref_propriete),
    constraint pk_refcaution PRIMARY KEY (ref_caution),
    Engine=InnoDB,  
    ON DELETE CASCADE,
    ON UPDATE CASCADE
);

CREATE TABLE Photo (
    id INT PRIMARY KEY,
    url VARCHAR(255),
    legende VARCHAR(255),
    ref_p INT,
    FOREIGN KEY (ref_propriete) REFERENCES Propriete(id)
);
