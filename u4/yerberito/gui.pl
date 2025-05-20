:- use_module(library(pce)).
:- consult('reglas.pl').
:- ensure_loaded('conocimiento.pl').

inicio :-
    new(V, dialog('Consulta de Plantas Medicinales')),
    send(V, size, size(450, 600)),

    % Campo de entrada para nombre de la planta
    send(V, append, new(EntradaPlanta, text_item('Nombre de la planta'))),
    send(EntradaPlanta, name, entrada_planta),

    % Botones para consultas por planta
    send(V, append, button('Nombre cientifico',
        message(@prolog, ejecutar_opcion, nombre, V)), below),
    send(V, append, button('Origen',
        message(@prolog, ejecutar_opcion, origen, V)), below),
    send(V, append, button('Enfermedades que trata',
        message(@prolog, ejecutar_opcion, enfermedades, V)), below),
    send(V, append, button('Sintomas de enfermedades',
        message(@prolog, ejecutar_opcion, sintomas, V)), below),
    send(V, append, button('Modo de preparacion',
        message(@prolog, ejecutar_opcion, preparacion, V)), below),
    send(V, append, button('Acciones de la planta',
        message(@prolog, ejecutar_opcion, acciones, V)), below),
    send(V, append, button('Mostrar toda la informacion',
        message(@prolog, ejecutar_opcion, toda, V)), below),

    % Separador visual
    send(V, append, label(separador, '----------------------------------------'), below),

    % Men� desplegable para tipo de b�squeda (enfermedad o continente)
    send(V, append, new(TipoBusqueda, menu('Tipo de b�squeda', choice))),
    send(TipoBusqueda, append, 'Enfermedad'),
    send(TipoBusqueda, append, 'Continente'),
    send(TipoBusqueda, name, tipo_busqueda),

    % Campo de entrada para enfermedad o continente
    send(V, append, new(EntradaBusqueda, text_item('Ingrese enfermedad o continente'))),
    send(EntradaBusqueda, name, entrada_busqueda),

    % Bot�n Buscar para enfermedad o continente
    send(V, append, button('Buscar',
        message(@prolog, buscar_plantas,
                TipoBusqueda?selection,
                EntradaBusqueda?selection,
                V)), below),

    % �rea de salida
    new(Salida, editor),
    send(Salida, size, size(40, 6)),
    send(Salida, name, salida),
    send(V, append, Salida, below),

    % �rea para la imagen
    new(Imagen, bitmap),
    send(Imagen, name, imagen),
    send(V, append, Imagen, below),

    send(V, open).

% Controla la acci�n seg�n el bot�n presionado
ejecutar_opcion(toda, Ventana) :-
    mostrar_info_completa(Ventana).
ejecutar_opcion(Filtro, Ventana) :-
    mostrar_info_filtro(Filtro, Ventana).

% Buscar info filtrada
mostrar_info_filtro(Filtro, Ventana) :-
    get(Ventana, member, entrada_planta, Entrada),
    get(Entrada, selection, PlantaInput),
    % Convertir entrada a �tomo y a min�sculas
    atom_string(PlantaAtom, PlantaInput),
    downcase_atom(PlantaAtom, PlantaLower),
    % Verificar si la planta existe
    (   nombre_cientifico(PlantaLower, _) ->
        findall(Linea, info_filtrada(Filtro, PlantaLower, Linea), Lineas),
        (   Lineas == [] ->
            atom_concat('No se encontr� informaci�n para ', PlantaLower, Texto)
        ;   atomic_list_concat(Lineas, '\n', Texto))
    ;   atom_concat('Planta no encontrada: ', PlantaLower, Texto)
    ),
    get(Ventana, member, salida, CampoTexto),
    send(CampoTexto, clear),
    send(CampoTexto, insert, Texto),
    % Cargar y mostrar la imagen
    atom_concat('C:\\Users\\alexe\\Downloads\\u4\\yerberito\\imgs\\', PlantaLower, BasePath),
    atom_concat(BasePath, '.jpg', FilePath),
    (   exists_file(FilePath) ->
        get(Ventana, member, salida, Salida),
        get(Salida, width, EditorWidth),
        get(Ventana, member, imagen, Imagen),
        send(Imagen, load, FilePath),
        send(Imagen, size, size(EditorWidth, 0))
    ;   get(Ventana, member, imagen, Imagen),
        send(Imagen, load, '')
    ).

% Buscar toda la info
mostrar_info_completa(Ventana) :-
    get(Ventana, member, entrada_planta, Entrada),
    get(Entrada, selection, PlantaInput),
    % Convertir entrada a �tomo y a min�sculas
    atom_string(PlantaAtom, PlantaInput),
    downcase_atom(PlantaAtom, PlantaLower),
    % Verificar si la planta existe
    (   nombre_cientifico(PlantaLower, _) ->
        findall(Linea, info_planta(PlantaLower, Linea), Lineas),
        (   Lineas == [] ->
            atom_concat('No se encontr� informaci�n para ', PlantaLower, Texto)
        ;   atomic_list_concat(Lineas, '\n', Texto))
    ;   atom_concat('Planta no encontrada: ', PlantaLower, Texto)
    ),
    get(Ventana, member, salida, CampoTexto),
    send(CampoTexto, clear),
    send(CampoTexto, insert, Texto),
    % Cargar y mostrar la imagen
    atom_concat('C:\\Users\\alexe\\Downloads\\u4\\yerberito\\imgs\\', PlantaLower, BasePath),
    atom_concat(BasePath, '.jpg', FilePath),
    (   exists_file(FilePath) ->
        get(Ventana, member, salida, Salida),
        get(Salida, width, EditorWidth),
        get(Ventana, member, imagen, Imagen),
        send(Imagen, load, FilePath),
        send(Imagen, size, size(EditorWidth, 0))
    ;   get(Ventana, member, imagen, Imagen),
        send(Imagen, load, '')
    ).

% Buscar plantas por enfermedad o continente
buscar_plantas(Tipo, EntradaInput, Ventana) :-
    % Convertir entrada a �tomo y a min�sculas
    atom_string(EntradaAtom, EntradaInput),
    downcase_atom(EntradaAtom, EntradaLower),
    % Seleccionar predicado seg�n tipo de b�squeda
    (   Tipo = 'Enfermedad' ->
        (   enfermedad(EntradaLower) ->
            findall(Planta, trata_enfermedad(Planta, EntradaLower), Plantas),
            (   Plantas = [] ->
                atom_concat('No se encontraron plantas para la enfermedad: ', EntradaLower, Texto)
            ;   atomic_list_concat(Plantas, ', ', PlantasStr),
                atom_concat('Plantas que tratan ', EntradaLower, Texto1),
                atom_concat(Texto1, ': ', Texto2),
                atom_concat(Texto2, PlantasStr, Texto)
            )
        ;   atom_concat('Enfermedad no encontrada: ', EntradaLower, Texto)
        )
    ;   Tipo = 'Continente' ->
        findall(Planta, continente_origen(Planta, EntradaLower), Plantas),
        (   Plantas = [] ->
            atom_concat('No se encontraron plantas del continente: ', EntradaLower, Texto)
        ;   atomic_list_concat(Plantas, ', ', PlantasStr),
            atom_concat('Plantas de ', EntradaLower, Texto1),
            atom_concat(Texto1, ': ', Texto2),
            atom_concat(Texto2, PlantasStr, Texto)
        )
    ;   Texto = 'Por favor, seleccione un tipo de b�squeda.'
    ),
    % Mostrar resultados en el �rea de texto
    get(Ventana, member, salida, CampoTexto),
    send(CampoTexto, clear),
    send(CampoTexto, insert, Texto),
    % Mostrar imagen de la primera planta encontrada (si existe)
    (   Plantas \= [],
        Plantas = [PrimeraPlanta|_],
        downcase_atom(PrimeraPlanta, PlantaLower),
        atom_concat('C:\\Users\\alexe\\Downloads\\u4\\yerberito\\imgs\\', PlantaLower, BasePath),
        atom_concat(BasePath, '.jpg', FilePath),
        exists_file(FilePath) ->
        get(Ventana, member, salida, Salida),
        get(Salida, width, EditorWidth),
        get(Ventana, member, imagen, Imagen),
        send(Imagen, load, FilePath),
        send(Imagen, size, size(EditorWidth, 0))
    ;   get(Ventana, member, imagen, Imagen),
        send(Imagen, load, '')
    ).

% Filtros espec�ficos
info_filtrada(nombre, Planta, Linea) :-
    nombre_cientifico(Planta, Nombre),
    atom_concat('Nombre cientifico: ', Nombre, Linea).
info_filtrada(origen, Planta, Linea) :-
    (   continente_origen(Planta, Continente),
        atom_concat('Continente de origen: ', Continente, Linea)
    ;   pais_origen(Planta, Pais),
        atom_concat('Pais de origen: ', Pais, Linea)
    ).
info_filtrada(enfermedades, Planta, Linea) :-
    trata_enfermedad(Planta, Enfermedad),
    atom_concat('Trata enfermedad: ', Enfermedad, Linea).
info_filtrada(sintomas, Planta, Linea) :-
    trata_enfermedad(Planta, Enfermedad),
    sintoma_enfermedad(Enfermedad, Sintoma),
    format(atom(Linea), 'Sintoma de ~w: ~w', [Enfermedad, Sintoma]).
info_filtrada(preparacion, Planta, Linea) :-
    (   modo_preparacion(Planta, Forma),
        atom_concat('Modo de preparacion: ', Forma, Linea)
    ;   modo_tratamiento(Planta, Trat),
        format(atom(Linea), 'Modo de tratamiento: ~w', [Trat])
    ).
info_filtrada(acciones, Planta, Linea) :-
    acciones_de_plantas(Planta, Accion),
    format(atom(Linea), 'Accion de la planta: ~w', [Accion]).

:- initialization(inicio).
