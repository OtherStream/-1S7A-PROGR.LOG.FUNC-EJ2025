% reglas.pl
:- consult('conocimiento.pl').  % Cargar hechos

% 1. Cuales son plantas o plantas medicinales?
plantas_medicinales(Planta) :-
    nombre_cientifico(Planta, _).

% Permite usar descripcion_accion/2 como si fuera diccionario/2
diccionario(Termino, Definicion) :-
    descripcion_accion(Termino, Definicion).

% Descripción de una acción específica
descripcion_de_accion(Accion, Descripcion) :-
    descripcion_accion(Accion, Descripcion).

% Acciones y sus descripciones asociadas a una planta
acciones_y_descripciones(Planta, Accion, Descripcion) :-
    acciones_de_plantas(Planta, Accion),
    descripcion_accion(Accion, Descripcion).

% 11. Listado de plantas y sus acciones o efectos sobre el organismo
plantas_y_acciones(Planta, Accion) :-
    acciones_de_plantas(Planta, Accion).

% 12. Acciones o efectos de una planta en especifico
acciones_de_una_planta(Planta, Accion) :-
    acciones_de_plantas(Planta, Accion).

% 13. Cuales son las plantas analgesicas? (acciones que incluyen 'analgesico' o similar)
plantas_analgesicas(Planta) :-
    acciones_de_plantas(Planta, Accion),
    sub_atom(Accion, _, _, _, analgesico).

% 14. Listar plantas medicinales y su nombre cientifico
plantas_y_nombre_cientifico(Planta, NombreCientifico) :-
    nombre_cientifico(Planta, NombreCientifico).

% 15. Cuales son las enfermedades que curan las plantas?
enfermedades_que_curan_las_plantas(Enfermedad) :-
    trata_enfermedad(_, Enfermedad).

% 16. Cuales son las enfermedades que cura una planta en especifico? (ejemplo: sabila)
enfermedades_de_una_planta(Planta, Enfermedad) :-
    trata_enfermedad(Planta, Enfermedad).

% 17. Cuales son las plantas que curan una enfermedad? (ejemplo: herpes)
plantas_que_curan_enfermedad(Enfermedad, Planta) :-
    trata_enfermedad(Planta, Enfermedad).

% 18. Cuales son las formas de preparacion para tratamiento de enfermedades con uso de plantas?
formas_preparacion(Forma) :-
    modo_preparacion(_, Forma).

% 19. Cuales son los modos de preparacion de una planta en especifico?
modos_preparacion_de_planta(Planta, Forma) :-
    modo_preparacion(Planta, Forma).

% 20. Cual es el tratamiento y su preparacion para alguna enfermedad?
tratamiento_para_enfermedad(Enfermedad, Planta, Forma) :-
    trata_enfermedad(Planta, Enfermedad),
    modo_preparacion(Planta, Forma).

% 21. Cuales son los origenes de las plantas medicinales?
origenes_de_plantas(Origen) :-
    (continente_origen(_, Origen); pais_origen(_, Origen)).

% 22. Cual es el origen de una planta?
origen_de_una_planta(Planta, Origen) :-
    (continente_origen(Planta, Origen); pais_origen(Planta, Origen)).

% 23. Cual es el tratamiento para una enfermedad?
tratamiento_de_enfermedad(Enfermedad, TipoTratamiento, Tratamiento) :-
    trata_enfermedad(Tratamiento, Enfermedad),
    TipoTratamiento = planta.

% 24. Botiquin de plantas: listado completo de plantas, sus enfermedades y tratamientos
botiquin_de_plantas(Planta, Enfermedad, Tratamiento) :-
    trata_enfermedad(Planta, Enfermedad),
    (modo_preparacion(Planta, Tratamiento); modo_tratamiento(Planta, Tratamiento)).

% 25. Cuales son las formas de uso de una planta?
forma_uso(Planta, Uso) :-
    (modo_preparacion(Planta, Uso); modo_tratamiento(Planta, Uso)).

% Reglas originales de info_planta/2
info_planta(Planta, Linea) :-
    nombre_cientifico(Planta, Nombre),
    atom_concat('Nombre cientifico: ', Nombre, Linea).

info_planta(Planta, Linea) :-
    continente_origen(Planta, Continente),
    atom_concat('Continente de origen: ', Continente, Linea).

info_planta(Planta, Linea) :-
    pais_origen(Planta, Pais),
    atom_concat('Pais de origen: ', Pais, Linea).

info_planta(Planta, Linea) :-
    modo_preparacion(Planta, Modo),
    atom_concat('Modo de preparacion: ', Modo, Linea).

info_planta(Planta, Linea) :-
    modo_tratamiento(Planta, Trat),
    format(atom(Linea), 'Modo de tratamiento: ~w', [Trat]).

info_planta(Planta, Linea) :-
    acciones_de_plantas(Planta, Accion),
    format(atom(Linea), 'Accion de la planta: ~w', [Accion]).

info_planta(Planta, Linea) :-
    trata_enfermedad(Planta, Enfermedad),
    format(atom(Linea), 'Trata enfermedad: ~w', [Enfermedad]).

info_planta(Planta, Linea) :-
    trata_enfermedad(Planta, Enfermedad),
    sintoma_enfermedad(Enfermedad, Sintoma),
    format(atom(Linea), 'Sintoma de ~w: ~w', [Enfermedad, Sintoma]).












