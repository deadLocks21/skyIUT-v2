unit unitAffichage;

{$codepage utf8}

interface

(*#########################################################*)
(*                                                         *)
(*   ###  #  #  #####  ####  ###   ####   ###   ##   ####  *)
(*    #   ## #    #    #     #  #  #     #  #  #  #  #     *)
(*    #   # ##    #    ##    #  #  ##    #  #  #     ##    *)
(*    #   #  #    #    #     ###   #     ####  #  #  #     *)
(*   ###  #  #    #    ####  #  #  #     #  #   ##   ####  *)
(*                                                         *)
(*#########################################################*)

uses unitEcran, unitMenuInitiale, unitMenuCreationPersonnage, unitMenuQuete, unitMenuInventaire, unitMenuJeu, typesDuJeu, sysutils;



    (*#################################################################*)
    (*                                                                 *)
    (*  ####  #  #  #  #   ##   #####      #  ####  ###    ###    ##   *)
    (*  #     #  #  ## #  #  #    #       #   #  #  #  #  #  #   #  #  *)
    (*  ###   #  #  # ##  #       #      #    ###   #  #  #  #   #     *)
    (*  #     #  #  #  #  #  #    #     #     #     ###   #  #   #  #  *)
    (*  #      ##   #  #   ##     #    #      #     #  #   ##     ##   *)
    (*                                                                 *)
    (*#################################################################*)

{Initialise la taille et le cadre de la console}
procedure initConsole();

(*Attend une réponse de la part de l'utilisateur.*)
function jeVeuxUneReponse() : String;

(*Vérifie si la masse d'ébonite est dans l'inventaire. Retourne TRUE si oui.*)
function presenceMasseEbo(p:personnage):Boolean;




(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuInitiale(var qF : String);

(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuCreationPersonnage(var joueur : Personnage);

(*Procedure qui affiche la fenetre de jeu principale.*)
procedure affMenuJeu(var p : Personnage; var rep : String);

(*Procedure qui affiche la quête actuelle*)
procedure affMenuQuete(var p : Personnage; var rep : String);

(*Procedure qui affiche le menu de inventaire.*)
procedure affMenuInv(var pe : Personnage; var rep : String);

(*Procedure qui affiche le magasin du jeu.*)
procedure affMenuMag(var p : Personnage; rep : String);




implementation

(*#########################################################################################*)
(*                                                                                         *)
(*   ###  #   #  ####  #     ####  #   #  ####  #  #  #####   ###  #####  ###   ###  #  #  *)
(*    #   ## ##  #  #  #     #     ## ##  #     ## #    #    #  #    #     #   #  #  ## #  *)
(*    #   # # #  ###   #     ##    # # #  ##    # ##    #    #  #    #     #   #  #  # ##  *)
(*    #   #   #  #     #     #     #   #  #     #  #    #    ####    #     #   #  #  #  #  *)
(*   ###  #   #  #     ####  ####  #   #  ####  #  #    #    #  #    #    ###   ##   #  #  *)
(*                                                                                         *)
(*#########################################################################################*)

{Initialise la taille et le cadre de la console}
procedure initConsole();
begin
  changerTailleConsole(200, 60);
  effacerEcran;
  dessinerCadreXY(2,1,196,58,double,15,0);
end;

(*Attend une réponse de la part de l'utilisateur.*)
function jeVeuxUneReponse() : String;
var
  rep : String;
begin
  ReadLn(rep);
  jeVeuxUneReponse:=rep;
end;

(*Vérifie si la masse d'ébonite est dans l'inventaire. Retourne TRUE si oui.*)
function presenceMasseEbo(p:personnage):Boolean;
var
  i:Integer;
  rep : Boolean;

begin
rep:=FALSE;

  for i:=1 to 12 do
    begin
      if  p.inv[i]='Masse d''ebonite' then
        begin
          rep:=TRUE;
        end;
    end;
  presenceMasseEbo:=rep;
end;





(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuInitiale(var qF : String);
var
  rep : String;  // Variable qui vaut n ou k pour respectivement créer une nouvelle partie ou killer le jeu.

begin
  initConsole();

  affichageTextesMI();

  repeat
    centrerTexte('                  ', 49, 100);
    centrerTexte('', 49, 100);
    rep := jeVeuxUneReponse();
  until (rep = '1') OR (rep = '2');

  if rep = '1' then rep := 'n';
  if rep = '2' then rep := 'exit';

  qF := rep;
end;

(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuCreationPersonnage(var joueur : Personnage);
var
  ctn : Boolean;
  nom : String;
  race : Integer;

begin
  ctn := True;

  while ctn do
    begin
      initConsole();

      // Demande du nom du joueur
      affTexteDemandeNomPersMCP;
      nom :=jeVeuxUneReponse();

      centrerPseudoMCP(nom);

      // Affiche les races
      affRacesMCP;

      // Vérifie et donne la race que l'utilisateur désire.
      race := choixRaceMCP();

      ctn := confirmationMCP();
    end;

  creerPersonnage(joueur, nom, race);
end;

(*Procedure qui affiche la fenetre de jeu principale.*)
procedure affMenuJeu(var p : Personnage; var rep : String);
begin
  initConsole();
  initCadreHautMJ(p);
  initCadreBasMJ();

  rep:='';

  affTexte(#09'Bienvenue dans notre jeu jeune aventurier. Je te propose ici de pouvoir tester de manière simple les différentes fonctions de notre jeu telles que le megasin, l''inventaire. Amuse-toi bien dans ce test !!', 13);
  affTexte('Mince UN LOUP VOUS ATTAQUE !! Il faut réagir vite, que voulez vous faire ?!!', 15);

  centrerTexte('1/ Fuir', 47, 66);
  centrerTexte('2/ Combattre', 47, 133);

  repeat
    razConsole;

    rep:=jeVeuxUneReponse();
  until (rep='exit') OR (rep='a') OR (rep='b') OR (rep='1') OR (rep='2');

   if rep='a' then rep := 'Inventaire';
   if rep='b' then rep := 'Magasin';
   if rep='1' then rep := 'Mourrir';
   if rep='2' then rep := 'LancerCombat !!';
end;

(*Procedure qui affiche la quête actuelle*)
procedure affMenuQuete(var p : Personnage; var rep : String);
var
  pos : coordonnees;
  //rep : String;
begin
  initConsole();

  initCadreHautMQ(p);

  if p.quete = 1 then centrerTexte('Retrouver le Jarl de Blancherive dans le Fort Dragon', 30, 100);
  if p.quete = 2 then centrerTexte('Retrouver le Chambellan : Cavovius Dargogne', 30, 100);
  if p.quete = 3 then centrerTexte('Rejoindre la porte principale de Blancherive', 30, 100);
  if p.quete = 4 then centrerTexte('Retrouver les soldats à la Tour de Guet', 30, 100);
  if p.quete = 5 then centrerTexte('Aller a l’armurerie de Blancherive pour s’équiper de la Masse d’Ebonite', 30, 100);
  if p.quete = 6 then centrerTexte('Retourner à la Tour de Guet combattre le Dragon', 30, 100);
  if p.quete = 7 then centrerTexte('Vaincre le Dragon', 30, 100);


  initCadreBasMQ();

  repeat
    changerLigneCurseur(56);
    changerColonneCurseur(10);
    Write('>>>                                             ');
    changerColonneCurseur(14);

    rep := jeVeuxUneReponse();

  until (rep = 'a') OR (rep = 'exit');

  if rep = 'a' then rep := 'OK';
end;

(*Procedure qui affiche le menu de inventaire.*)
procedure affMenuInv(var pe : Personnage; var rep : String);
var
  pos : coordonnees;
  //rep : String;
  A, B, C, D, E, F, G, H, I, J, K, P, Q : Boolean;
begin
  initAffMInv(pe);

  repeat
    repeat
      changerLigneCurseur(56);
      changerColonneCurseur(10);
      Write('>>>                                             ');
      changerColonneCurseur(14);

      rep := jeVeuxUneReponse();
      centrerTexte('                                                                                                                                      ', 48, 100);

      P := Length(rep)=3;
      Q := Length(rep)=4;
      A := rep = 'exit';
      B := rep = 'a';
      C := rep = 'b';

      if rep <> '' then
        begin
          E := rep[1] = 'e';
          F := rep[2] = '-';
          G := Ord(rep[3]) <= Ord('9');
          H := Ord(rep[3]) > Ord('0');
          I := Ord(rep[3]) = Ord('1');
          J := Ord(rep[4]) >= Ord('0');
          K := Ord(rep[4]) < Ord('3');
        end;

    until A OR B OR C OR ( E AND F AND ( (P AND G AND H) OR (Q AND I AND J AND K) ) );



    if rep='a' then utiliserUnePotion(pe);

    if ( E AND F AND ( (P AND G AND H) OR (Q AND I AND J AND K) ) ) then tenterDEquiperLeJoueur(pe, rep);




  until A OR C;

  if rep = 'b' then rep := 'OK';
end;

(*Procedure qui affiche le magasin du jeu.*)
procedure affMenuMag(var p : Personnage; rep : String);
var
  pos : coordonnees;
  //rep : String;
  armur : Armurerie;
  len, cb : Integer;
begin
  initAffMag(p);
  initArmurerie(armur);

    repeat
      rep:='';

      repeat
        changerLigneCurseur(56);
        changerColonneCurseur(10);
        Write('>>>                                             ');
        changerColonneCurseur(14);

        rep := jeVeuxUneReponse();
        centrerTexte('                                                                                                                                      ', 48, 100);

          // R AND ( ( A AND B AND ( S OR T ) ) OR ( C AND D AND ( (S AND E) OR ( T AND F ) ) ) )

      until (rep='a') OR ( rep='exit' ) OR ( ( rep[2] = '-' ) AND ( ( (Length(rep) = 3) AND ( Ord(rep[3]) < 58 ) AND ( Ord(rep[3]) > 48 ) AND ( ( rep[1] = 'a' ) OR ( rep[1] = 'v' ) ) ) OR ( (Length(rep) = 4) AND ( rep[3] = '1' ) AND ( Ord(rep[4]) > 47 ) AND ( ( ( rep[1] = 'a' ) AND ( Ord(rep[4]) < 58 ) ) OR ( ( rep[1] = 'v' ) AND ( Ord(rep[4]) < 51 ) ) ) ) ) );


      if (rep <> 'a') AND (rep <> 'exit') then
      begin
        len := Length(rep);

        case len of
          3: cb:=StrToInt(rep[3]);
          4: cb:=StrToInt(rep[4])+10;
        end;

        if (rep[1] = 'a') then
          begin
            if p.gold >= armur[cb-1].prix then
              begin
                if placeInventaire(p) then
                  begin
                    p.gold := p.gold - armur[cb-1].prix;
                    ajouterObjet(p, armur[cb-1].nom);

                    if (cb = 10) AND (p.quete=5) then p.quete:=6;


                    initAffMag(p);

                    centrerTexte('                                            Tu viens d''acheter un nouvel item, bravo !!                                            ', 48, 100);
                  end
                else
                  centrerTexte('                                            T''as plus de place, je peux rien faire pour toi ...                                            ', 48, 100);
              end
            else
              centrerTexte('                                                   T''es pauvre déso ...                                                   ', 48, 100);
          end
        else
          begin
            if p.inv[cb] <> '' then
              begin
                p.gold := p.gold + Round(trouverPrixObj(p, cb)*0.5);

                enleverObjet(p, p.inv[cb]);
                enleverEquipement(p);

                initAffMag(p);

                centrerTexte('                                            Tu viens de vendre un item, bravo !!                                            ', 48, 100);
              end
            else
              centrerTexte('                                              Heuuu tu peux vendre le vide toi ?!                                              ', 48, 100);
          end;
      end;

    until (rep='a') OR (rep='exit');

  if rep = 'a' then rep := 'OK';
end;

end.
