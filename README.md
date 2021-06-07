# Autocomplete Widget

Aquest document inclou l'explicació del widget [AutoComplete Widget](https://api.flutter.dev/flutter/material/Autocomplete-class.html) i un exemple per entendre'n millor el funcionament.

## Per a què serveix el widget

L'objectiu de l'[AutoComplete Widget](https://api.flutter.dev/flutter/material/Autocomplete-class.html) és ajudar l'usuari a acabar d'escriure inputs en forma de text. Quan l'usuari comença a escriure un text, se li mostra un llistat d'opcions que coincideixen amb el que porta escrit i, si la selecciona, s'autocompleta.

## Paràmetres del widget

Els principals paràmetres del widget són els següents:

-   [optionsBuilder](https://api.flutter.dev/flutter/material/Autocomplete/optionsBuilder.html) - **Obligatori** Una funció que, donat un text escrit, retorni el llistat d'opcions que s'hi adeqüen. Hauria de tenir en compte que pot ser que el text estigui buit.
-   [onSelected](https://api.flutter.dev/flutter/material/Autocomplete/onSelected.html) - Una funció que, donada la opció seleccionada, faci alguna acció.
-   [displayStringOption](https://api.flutter.dev/flutter/material/Autocomplete/displayStringForOption.html) - Una funció que, donada una opció, en retorni l'String que s'hauria de mostrar.

## Com utilitzar el widget

Construim el widget indicant quin tipus s'utilitzarà com a llista - pot ser qualsevol tipus de llista - i passant com a paràmetre [optionsBuilder](https://api.flutter.dev/flutter/material/Autocomplete/optionsBuilder.html).

Aquesta funció, que té el text que s'ha escrit fins ara com a paràmetre, ha de tornar un llistat d'opcions del tipus indicat. No obstant això, si s'utilitza un tipus diferent d'String, caldrà utilitzar també el paràmetre [displayStringOption](https://api.flutter.dev/flutter/material/Autocomplete/displayStringForOption.html) i indicar-li quina String volem que es mostri per cadascuna de les opcions.

Finalment, si volem que faci alguna acció quan es seleccioni una opció, podem utilitzar el paràmetre [onSelected](https://api.flutter.dev/flutter/material/Autocomplete/onSelected.html).

## Exemple del widget

Podem obtenir un exemple del widget aquí. Per fer-lo funcionar haurem d'instal·lar el projecte utilitzant el comandament `flutter pub get` i iniciar-lo amb `flutter run`.

L'objectiu de l'exemple es trobar un usuari introduïnt el seu correu electrònic. Si introduïm primer la província, només es mostraran els correus electrònics amb els usuaris d'aquella província.

Així doncs, veiem dos exemples d'ús de l'Autocomplete. El primer, de la província, ens mostra com a opcions les províncies que tenen els usuaris, sense caldre escriure res. És una llista d'Strings, per tant no cal utilitzar [displayStringOption](https://api.flutter.dev/flutter/material/Autocomplete/displayStringForOption.html).

El segon, ens mostra els correus electrònics de tots els usuaris que compleixin la condició de la província, si existeix. Aquí les opcions són Users, per tant és obligatori utilitzar [displayStringOption](https://api.flutter.dev/flutter/material/Autocomplete/displayStringForOption.html). Cal començar a escriure alguna cosa per tal que es vegin les opcions.

Finalment, mostrem la informació de l'usuari que es correspon al correu electrònic.
