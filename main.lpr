program main;

{$codepage utf8}

uses unitEcran, unitAffichage, typesDuJeu, unitMenuCreationPersonnage,
  unitMenuQuete, unitMenuInventaire, unitDate, sysutils, unitSauvegardeTools;


var
  hamadi : Boolean;  // Pas boolean juste boulet.
  qF : String;  // Variable qui permet de récupérer ce que veut faire l'utilisateur.
  ctn : Boolean;  // Variable booléene qui fait tourner la boule principale de jeu.
  joueur : Personnage;



begin
  changerTailleConsole(200, 60);
  effacerEcran;
  dessinerImageMenuDem('logo_EDT.txt', 6);
  dessinerImageMenuDem('dessin_EDT.txt', 28);


  ReadLn;

  ctn := True;
  affMenuInitiale(qF);

  if qF = 'exit' then ctn := False;
  if qF = 'n' then affMenuCreationPersonnage(joueur);
  if qF = 'r' then lireSaveJ(joueur);

  //creerPersonnage(joueur, 'deadLocks21', 1);
  //initDate(joueur);

  //joueur.quete:=4;
  //joueur.lieu:='g';
  //joueur.inv[1] := 'Masse d''ebonite';
  //joueur.dateAjh.heure:=19;

  // Test du temps !!
  //while 1=1 do
  //  begin
  //    avancerMinutes(joueur, 10);
  //    WriteLn(IntToStr(joueur.dateAjh.heure) + ':' + IntToStr(joueur.dateAjh.minute) + ' ' + IntToStr(joueur.dateAjh.jour) + '/' + IntToStr(joueur.dateAjh.mois) + '/' + IntToStr(joueur.dateAjh.annee));
  //  end;

  //saveJ(joueur);

  while ctn do
    begin
      affMenuJeu(joueur, qF);

      case qF of
        'Inventaire' : affMenuInv(joueur, qF);
        'Quete' : affMenuQuete(joueur, qF);
        'Magasin' : affMenuMag(joueur, qF);
        'Mourrir' : ctn := False;
      end;

      if qF = 'exit' then ctn := False;
    end;
end.

