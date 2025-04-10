% CEMPASUCHIL
planta(cempasuchil).
nombre_cientifico(cempasuchil, tagetes_erecta).
parte_utilizada(cempasuchil, hoja).
preparacion(cempasuchil, te).
sirve_para(cempasuchil, expulsar_parasitos_intestinales).
sirve_para(cempasuchil, curar_dolor_estomago).
sirve_para(cempasuchil, reblandecer_tejidos).
sirve_para(cempasuchil, tratar(abscesos)).
sirve_para(cempasuchil, tratar(tumores)).
caracteristica(cempasuchil, se_usa_para_dia_de_muertos).
caracteristica(cempasuchil, amarillo).

% CHAPARRO AMARGOSO
planta(chaparro_amargoso).
nombre_cientifico(chaparro_amargoso, castela_americana).
tipo(chaparro_amargoso, arbusto).
parte_utilizada(chaparro_amargoso, hojas).
parte_utilizada(chaparro_amargoso, corteza).
preparacion(chaparro_amargoso, te).
sirve_para(chaparro_amargoso, disenteria_amebiana).
sirve_para(chaparro_amargoso, diarreas).
sirve_para(chaparro_amargoso, flujos).
sirve_para(chaparro_amargoso, hemorragias_internas).
caracteristica(chaparro_amargoso, flores_rosas).

% CHICALOTE
planta(chicalote).
nombre_cientifico(chicalote, argemone_ochroleuca).
tipo(chicalote, planta_herbacea).
caracteristica(chicalote, espinas).
caracteristica(chicalote, flor_amarilla_blanquecina).
caracteristica(chicalote, semillas_negritas).
advertencia(chicalote, toxica).
sirve_para(chicalote, tos).
sirve_para(chicalote, asma).
sirve_para(chicalote, tosferina).
sirve_para(chicalote, epilepsia).
sirve_para(chicalote, artritis).
sirve_para(chicalote, insomnio).
sirve_para(chicalote, sistema_nervioso).
sirve_para(chicalote, ansiedad).
sirve_para(chicalote, desesperacion).
sirve_para(chicalote, colicos_hepaticos).
sirve_para(chicalote, colicos_renales).
sirve_para(chicalote, colicos_intestinales).
preparacion(chicalote, cocimiento).
preparacion(chicalote, semillas_molidas_con_leche).
sirve_para(chicalote, tina).
sirve_para(chicalote, sarna).

% CHILE
planta(chile).
nombre_cientifico(chile, capsicum_annuum).
parte_utilizada(chile, hojas).
preparacion(chile, panos_calientes_con_cocimiento).
sirve_para(chile, asma).
sirve_para(chile, reumatismo).
advertencia(chile, no_dar_a_ninos).
caracteristica(chile, sabroso).

% Una planta es medicinal si sirve para tratar enfermedades
planta_medicinal(P) :- sirve_para(P, _).

% Una planta es digestiva si trata problemas digestivos
digestiva(P) :- sirve_para(P, curar_dolor_estomago).
digestiva(P) :- sirve_para(P, expulsar_parasitos_intestinales).
digestiva(P) :- sirve_para(P, diarreas).
digestiva(P) :- sirve_para(P, flujos).

% Plantas tóxicas
planta_toxica(P) :- advertencia(P, toxica).

% Plantas que no deben darse a niños
no_apto_para_ninos(P) :- advertencia(P, no_dar_a_ninos).

% Plantas que se pueden preparar en té
se_puede_preparar_como_te(P) :- preparacion(P, te).

% Plantas sabrosas
sabrosa(P) :- caracteristica(P, sabroso).

% Tratamientos respiratorios
tratamiento_respiratorio(P) :- sirve_para(P, asma).
tratamiento_respiratorio(P) :- sirve_para(P, toses).
tratamiento_respiratorio(P) :- sirve_para(P, tosferina).

% Tratamientos dermatológicos
tratamiento_dermatologico(P) :- sirve_para(P, tina).
tratamiento_dermatologico(P) :- sirve_para(P, sarna).

% Tratamientos sistema nervioso
tratamiento_sistema_nervioso(P) :-
    sirve_para(P, sistema_nervioso);
    sirve_para(P, insomnio);
    sirve_para(P, ansiedad);
    sirve_para(P, desesperacion);
    sirve_para(P, epilepsia).


