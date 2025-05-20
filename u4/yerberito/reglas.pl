% 1. ¿Cuáles son plantas o plantas medicinales?
plantas_medicinales(Planta) :-
    planta(Planta).

% 2. ¿Qué elementos se encuentran en las plantas? (elementos distintos en todas las plantas)
elementos_en_plantas(Elemento) :-
    elemento_planta(_, Elemento).

% 3. ¿Qué elementos tiene una planta en específico? (ejemplo: manzanilla)
elementos_de_planta(Planta, Elemento) :-
    elemento_planta(Planta, Elemento).

% 4. ¿Qué plantas producen medicamentos?
plantas_productoras_de_medicamentos(Planta) :-
    produce_medicamento(Planta, _).

% 5. ¿Qué medicamentos produce una planta en específico?
medicamentos_de_planta(Planta, Medicamento) :-
    produce_medicamento(Planta, Medicamento).

% 6. ¿Qué medicamentos provienen de plantas? (todos los medicamentos de la base)
medicamentos_de_plantas(Medicamento) :-
    produce_medicamento(_, Medicamento).

% 7. ¿Cuáles son las acciones o efectos de medicamentos provenientes de plantas?
acciones_de_medicamentos(Medicamento, Accion) :-
    efecto_medicamento(Medicamento, Accion).

% 8. ¿Cuáles son los efectos o acciones de un medicamento en específico?
acciones_de_medicamento(Medicamento, Accion) :-
    efecto_medicamento(Medicamento, Accion).

% 9. ¿Cuáles son las acciones o efectos que tienen las plantas?    
acciones_de_plantas(Planta, Accion) :-
    efecto_planta(Planta, Accion).

% 10. Significado de palabras que son acciones o efectos de plantas sobre organismo
significado_accion(Accion, Significado) :-
    significado(Accion, Significado).

% 11. Listado de plantas y sus acciones o efectos sobre el organismo
plantas_y_acciones(Planta, Accion) :-
    efecto_planta(Planta, Accion).

% 12. Acciones o efectos de una planta en específico
acciones_de_una_planta(Planta, Accion) :-
    efecto_planta(Planta, Accion).

% 13. ¿Qué plantas son analgésicas? (acciones que incluyen 'analgésico' o similar)
plantas_analgesicas(Planta) :-
    efecto_planta(Planta, Accion),
    sub_string(Accion, _, _, _, 'analgésico').

% 14. Listar plantas medicinales y su nombre científico
plantas_y_nombre_cientifico(Planta, NombreCientifico) :-
    planta(Planta),
    nombre_cientifico(Planta, NombreCientifico).

% 15. ¿Cuáles son las enfermedades que curan las plantas?
enfermedades_que_curan_las_plantas(Enfermedad) :-
    cura_enfermedad(_, Enfermedad).

% 16. ¿Cuáles son las enfermedades que cura una planta en específico? (ejemplo: zábila)
enfermedades_de_una_planta(Planta, Enfermedad) :-
    cura_enfermedad(Planta, Enfermedad).

% 17. ¿Cuáles son las plantas que curan una enfermedad? (ejemplo: herpes)
plantas_que_curan_enfermedad(Enfermedad, Planta) :-
    cura_enfermedad(Planta, Enfermedad).

% 18. ¿Cuáles son las formas de preparación para tratamiento de enfermedades con uso de plantas?
formas_preparacion(Forma) :-
    modo_preparacion(_, Forma).

% 19. ¿Cuáles son los modos de preparación de una planta en específico?
modos_preparacion_de_planta(Planta, Forma) :-
    modo_preparacion(Planta, Forma).

% 20. ¿Cuál es el tratamiento y su preparación para alguna enfermedad?
tratamiento_para_enfermedad(Enfermedad, Planta, Forma) :-
    cura_enfermedad(Planta, Enfermedad),
    modo_preparacion(Planta, Forma).

% 21. ¿Cuáles son los orígenes de las plantas medicinales? (continentes o países)
origenes_de_plantas(Origen) :-
    origen_planta(_, Origen).

% 22. ¿Cuál es el origen de una planta?
origen_de_una_planta(Planta, Origen) :-
    origen_planta(Planta, Origen).

% 23. ¿Cuál es el tratamiento para una enfermedad (ya sea con plantas o medicamentos)?
tratamiento_de_enfermedad(Enfermedad, TipoTratamiento, Tratamiento) :-
    (cura_enfermedad(Tratamiento, Enfermedad), TipoTratamiento = planta);
    (medicamento_trata_enfermedad(Tratamiento, Enfermedad), TipoTratamiento = medicamento).

% 24. Botiquín de plantas: listado completo de plantas, sus enfermedades y tratamientos
botiquin_de_plantas(Planta, Enfermedad, Tratamiento) :-
    cura_enfermedad(Planta, Enfermedad),
    modo_preparacion(Planta, Tratamiento).

% 25. ¿Cuáles son las formas de uso de una planta? (alias para modo_preparacion/2)
forma_uso(Planta, Uso) :-
    modo_preparacion(Planta, Uso).
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





