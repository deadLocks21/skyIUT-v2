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

uses unitEcran, unitMenuInitiale, unitMenuCreationPersonnage;



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




(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuInitiale(var qF : String);

(*Procedure qui modifie qF en fonction du choix de l'utilisateur, soit il ferme le jeu, soit il démare une nouvelle partie.*)
procedure affMenuCreationPersonnage(var qF : String);




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
procedure affMenuCreationPersonnage(var qF : String);
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
end;

end.

