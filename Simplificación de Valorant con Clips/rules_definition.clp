; ********************************
; DEFINICIÓN DE REGLAS
; ********************************

;Nombres de los agentes disponibles
(defrule imprimir-nombres
    ?i <- (start ?s)
    (test (eq ?s 0))
    =>

    (do-for-all-facts ((?a agents)) TRUE
        (printout t "Agente: " ?a:name crlf)
    )
    (retract ?i)
)

;Imprimir información de un agente según su nombre
(defrule info_agent
    ?i <- (name_agent ?n)
    (agents (name ?n) (ability-1 ?a1) (ability-2 ?a2) (ability-3 ?a3) (ability-4 ?a4) (agent_type ?t))
    (ability-1 (ability_name ?a1) (ability_description ?d1) (ability_damage ?dam1))
    (ability-2 (ability_name ?a2) (ability_description ?d2) )
    (ability-3 (ability_name ?a3) (ability_description ?d3) )
    (ability-4 (ability_name ?a4) (ability_description ?d4) )
     =>

    (printout t "Nombre: " ?n crlf)
    (printout t "Tipo: " ?t crlf)
    (printout t "Habilidades: " crlf)
    (printout t "1. " ?a1 " Descripción: " ?d1 " Daño: " ?dam1 crlf)
    (printout t "2. " ?a2 " Descripción: " ?d2 crlf)
    (printout t "3. " ?a3 " Descripción: " ?d3 crlf)
    (printout t "4. " ?a4 " Descripción: " ?d4 crlf)

    (retract ?i)
)

;Nombre de las armas disponibles
(defrule names_weapons
    ?i <- (weapon_names ?w)
    =>

    (do-for-all-facts ((?w weapon)) TRUE
        (printout t "Armas: " ?w:weapon_name crlf)
    )
    (retract ?i)
)

;Imprimir información de un arma según su nombre
(defrule weapon_info
    ?i <- (weapon_info ?wname)
    (weapon (weapon_name ?wname) (weapon_description ?wd) (damage ?d))
    =>

    (printout t "Nombre: " ?wname crlf)
    (printout t "Descripción: " ?wd crlf)
    (printout t "Daño: " ?d crlf)

    (retract ?i)
)

;Elegir un agente para la partida
(defrule main-character
    ?m <- (main_character ?name)
    (agents (name ?name) (ability-1 ?a1) (ability-2 ?a2) (ability-3 ?a3) (ability-4 ?a4) (agent_type ?t) (health ?ahealth) (state ?astate) (charger ?acharge))
    ?a <- (agent (name ?aname))
    =>

    (printout t "Has elegido: " ?name crlf)
    (modify ?a (name ?name) (ability-1 ?a1) (ability-2 ?a2) (ability-3 ?a3) (ability-4 ?a4) (agent_type ?t) (health ?ahealth) (state ?astate) (charger ?acharge))
    (retract ?m)
)

;Seleccionar un arma para la partida
(defrule main-weapon
    ?m <- (main_weapon ?wname)
    ?a <- (agent (name ?aname))
    (weapon (weapon_name ?wname))
    =>

    (printout t "Has elegido: " ?wname crlf)
    (modify ?a (weapon ?wname))
    (retract ?m)
)


;Regla para disparar
(defrule enfrentamiento
    ?i <- (shoot ?s)
    (test (eq ?s 0))
    ?aa <- (agent (name ?aname) (weapon ?wname) (state ?astate) (charger ?acharge))
    ?id <- (enemy (name ?ename) (health ?ehealth) )

    ; Daño que hace el arma del agente
    (weapon (weapon_name ?wname) (damage ?adamage))

    ; estado = 1
    (test (eq ?astate 1))

    ; cargador > 0
    (test (> ?acharge 0))
    =>

    (modify ?aa (charger (- ?acharge 1)))

    (bind ?prob (random 0 100))
    (if (and(<= ?prob 50)(> ?ehealth 0))
        then
        ; Actualiza la salud
        (bind ?newehealth (- ?ehealth ?adamage))
        (modify ?id (health ?newehealth))
        (printout t "---------------------------" crlf)
        (printout t ?aname " has dado en el blanco!" crlf)
        (printout t "Vida de " ?ename ": " ?newehealth crlf)

        else
        ; porb menor a 70 y mayor que 40
        (if (and(<= ?prob 80)(> ?ehealth 0))
            then
            (bind ?newehealth (- ?ehealth (/ ?adamage 2)))
            (modify ?id (health ?newehealth))
            (printout t "---------------------------" crlf)
            (printout t ?aname " casi acierta el tiro!" crlf)
            (printout t "Vida de " ?ename ": " ?newehealth crlf)
        
            ; prob menor a 100 y mayor que 70
        else
            (printout t "---------------------------" crlf)
            (printout t "Has fallado." crlf)
            (printout t "La vida de reyna sigue siendo: " ?ehealth crlf)
            (bind ?newehealth ?ehealth)
            (assert (shoot_enemy 0))
            (retract ?i)
            )
    )
    
    (assert (shoot_enemy 0))
    (retract ?i)
)


;Regla para que el enemigo dispare
(defrule enfrentamiento-enemigo
    ?i <- (shoot_enemy ?s)
    (test (eq ?s 0))

    ?aa <- (agent (health ?ahealth))
    ?id <- (enemy (weapon ?eweapon))
    ; Daño que hace el arma del enemigo
    (weapon (weapon_name ?eweapon) (damage ?edamage))
    =>


    (printout t crlf)
    (bind ?eprob (random 0 100))
    (if (and(<= ?eprob 30)(> ?ahealth 0))
        then
        ; Actualiza la salud
        (bind ?newehealth (- ?ahealth ?edamage))
        (modify ?aa (health ?newehealth))
        (printout t "---------------------------" crlf)
        (printout t "Reyna ha dado en el blanco!" crlf)
        ;(printout t ?aname " le quitó " ?adamage " de vida a " ?ename "." crlf)
        (printout t "Tu vida actual es: " ?newehealth crlf)

        else
        ; porb menor a 70 y mayor que 40
        (if (and(<= ?eprob 50)(> ?ahealth 0))
            then
            (bind ?newehealth (- ?ahealth (/ ?edamage 2)))
            (modify ?aa (health ?newehealth))
            (printout t "---------------------------" crlf)
            (printout t "Reyna casi acierta el tiro!" crlf)
            ;(printout t ?aname " le quitó " (/ ?adamage 2) " de vida a " ?ename "." crlf)
            (printout t "Tu vida actual es: " ?newehealth crlf)
        
            ; prob menor a 100 y mayor que 70
        else
            (printout t "---------------------------" crlf)
            (printout t "Reyna ha fallado." crlf)
            (printout t "Tu vida permanece en: " ?ahealth crlf)
            (bind ?newehealth ?ahealth)
            (retract ?i)
            )
    )

    
    (retract ?i)
    (printout t "---------------------------" crlf)
)


;Regla para usar la habilidad 1
(defrule use-ability-1
    ?us <- (abi ?u)
    (test (eq ?u 1))
    ?a <- (agent (name ?aname) (ability-1 ?a1) (health ?ahealth) (state ?astate))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    ?au <- (ability-1 (ability_name ?a1) (ability_damage ?adamage) (ability_uses ?auses))
    (test (> ?auses 0))
    (test (eq ?astate 0))
    =>


    (bind ?prob (random 0 100))
    (modify ?au (ability_uses (- ?auses 1)))
    (modify ?a (state 1))
    (bind ?newehealth (- ?ehealth ?adamage))
    (if (<= ?prob 60)
        then
        (printout t ?aname " lanzó la habilidad " ?a1 crlf)
        (modify ?id (health ?newehealth))
        (printout t "Vida de " ?ename ": " ?newehealth crlf)

        else 
        (printout t ?aname " falló la habilidad " ?a1 crlf)
        (printout t "Vida de Reyna: " ?ehealth crlf)
    )

    (retract ?us)
)



;Regla para usar la habilidad 2 : tipo cura o daño
(defrule use-ability-2
    ?us <- (abi ?u)
    (test (eq ?u 2))
    ?a <- (agent (name ?aname) (ability-2 ?a2) (state ?astate))
    ?au <- (ability-2 (ability_name ?a2) (ability_type ?atype) (ability_uses ?auses))

    ;Comprobar que la habilidad no se haya usado
    (test (> ?auses 0))

    ;Comprobar que esté escondido
    (test (eq ?astate 0))
    =>


    (modify ?au (ability_uses (- ?auses 1)))
    (modify ?a (state 1))
    ;Tipo 1 daño
    (if (eq ?atype 1)
        then 
        (retract ?us)
        (assert (damage ?a2))
        ;Tipo 0 cura
        else 
        (retract ?us)
        (assert (heal ?a2))
    )
)

;Regla para usar habilidad 2 de tipo daño
(defrule ability-2-damage
    ?d <- (damage ?a2)
    ?a <- (agent (name ?aname) (ability-2 ?a2))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    ?au <- (ability-2 (ability_name ?a2) (ability_damage ?adamage)(ability_uses ?auses))
    =>


    (bind ?newehealth (- ?ehealth ?adamage))
    (printout t ?aname " lanzó la habilidad " ?a2 crlf)

    (bind ?a2prob (random 0 100))
    (if (<= ?a2prob 60)
        then
        (modify ?id (health ?newehealth))
        (printout t "Vida de " ?ename ": " ?newehealth crlf)

        else 
        (printout t ?aname " falló la habilidad " ?a2 crlf)
        (printout t "Vida del enemigo: " ?ehealth crlf)
    )

    (retract ?d)
)


;Regla para usar habilidad 2 de tipo cura
(defrule ability-2-healing
    ?d <- (heal ?a2)
    ?a <- (agent (name ?aname) (ability-2 ?a2) (health ?ahealth))
    ?au <- (ability-2 (ability_name ?a2) (healing_ability ?a2healing) (ability_uses ?auses))
    =>

    
    (bind ?newehealth (+ ?ahealth ?a2healing))
    (printout t "Te has curado!" crlf)
    (if (> ?newehealth 150)
        then
        (printout t "Tu vida actual es: 150" crlf)
        (modify ?a (health 150))

        else
        (printout t "Tu vida actual es: " ?newehealth crlf)
        (modify ?a (health ?newehealth))
    )    
    (retract ?d)
)



;Regla para usar la habilidad 3
(defrule use-ability-3
    ?us <- (abi ?u)
    (test (eq ?u 3))
    ?a <- (agent (name ?aname) (ability-3 ?a3) (state ?astate))
    ?au <- (ability-3 (ability_name ?a3) (ability_type ?atype) (ability_uses ?auses))
    
    ;No se ha usado y escondido
    (test (> ?auses 0))
    (test (eq ?astate 0))
    =>


    (modify ?au (ability_uses (- ?auses 1)))
    (modify ?a (state 1))
    ;Tipo 1 daño
    (if (eq ?atype 1)
        then 
        (retract ?us)
        (assert (damage-3 ?a3))
        ;Tipo 2 disparo asegurado
        else 
        (retract ?us)
        (assert (secure-shoot ?a3))
    )
)

;Regla para usar habilidad 3 de tipo daño
(defrule ability-3-damage
    ?d <- (damage-3 ?a3)
    ?a <- (agent (name ?aname) (ability-3 ?a3))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    ?au <- (ability-3 (ability_name ?a3) (ability_damage ?adamage)(ability_uses ?auses))
    =>


    (bind ?newehealth (- ?ehealth ?adamage))
    (printout t ?aname " lanzó la habilidad " ?a3 crlf)

    (bind ?a3prob (random 0 100))
    (if (<= ?a3prob 60)
        then
        (modify ?id (health ?newehealth))
        (printout t "Vida de " ?ename ": " ?newehealth crlf)

        else 
        (printout t ?aname " falló la habilidad " ?a3 crlf)
        (printout t "Vida de Reyna " ?ehealth crlf)
    )

    (retract ?d)
)

;Regla para usar habilidad 3 de tipo 2 -> disparo seguro
(defrule ability-3-shoot
    ?s <- (secure-shoot ?a3)
    ?a <- (agent (name ?aname) (weapon ?aweapon) (charger ?acharger))
    (test (> ?acharger 0))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    (weapon (weapon_name ?aweapon) (damage ?wdamage))
    (ability-3 (ability_name ?a3) (ability_description ?adescription) )
    =>


    (modify ?a (charger (- ?acharger 1)))
    (bind ?newehealth (- ?ehealth ?wdamage))
    (printout t ?aname " lanzó la habilidad " ?a3 crlf)
    (printout t ?adescription crlf)

    (printout t "Has dado en el blanco!" crlf)
    (printout t "Vida de " ?ename ": " ?newehealth crlf)
    (modify ?id(health ?newehealth))


    (retract ?s)
)



;Regla para usar la habilidad 4
(defrule use-ability-4
    ?us <- (abi ?u)
    (test (eq ?u 4))
    ?a <- (agent (name ?aname) (ability-4 ?a4) (state ?astate))
    ?au <- (ability-4 (ability_name ?a4) (ability_type ?atype) (ability_uses ?auses))
    
    ;No se ha usado y escondido
    (test (> ?auses 0))
    (test (eq ?astate 0))
    =>


    (modify ?au (ability_uses (- ?auses 1)))
    (modify ?a (state 1))
    ;Tipo 1 daño
    (if (eq ?atype 1)
        then 
        (retract ?us)
        (assert (damage-4 ?a4))

        ;Tipo 2 disparo asegurado
        else 
        (retract ?us)
        (assert (secure-shoot-4 ?a4))
    )
)

;Regla para usar habilidad 4 de tipo daño
(defrule ability-4-damage
    ?d <- (damage-4 ?a4)
    ?a <- (agent (name ?aname) (ability-4 ?a4))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    ?au <- (ability-4 (ability_name ?a4) (ability_damage ?adamage)(ability_uses ?auses))
    =>


    (bind ?newehealth (- ?ehealth ?adamage))
    (printout t ?aname " lanzó la habilidad " ?a4 crlf)

    (bind ?a3prob (random 0 100))
    (if (<= ?a3prob 60)
        then
        (modify ?id (health ?newehealth))
        (printout t "Vida de " ?ename ": " ?newehealth crlf)

        else 
        (printout t ?aname " falló la habilidad " ?a4 crlf)
        (printout t "Vida del enemigo " ?ehealth crlf)
    )

    (retract ?d)
)

;Regla para usar habilidad 4 de tipo 2 -> disparo seguro
(defrule ability-4-shoot
    ?s <- (secure-shoot-4 ?a4)
    ?a <- (agent (name ?aname) (weapon ?aweapon) (charger ?acharger))
    (test (> ?acharger 0))
    ?id <- (enemy (name ?ename) (health ?ehealth))
    (weapon (weapon_name ?aweapon) (damage ?wdamage))
    (ability-4 (ability_name ?a4) (ability_description ?adescription) )
    =>


    (modify ?a (charger (- ?acharger 1)))
    (bind ?newehealth (- ?ehealth ?wdamage))
    (printout t ?aname " lanzó la habilidad " ?a4 crlf)
    (printout t ?adescription crlf)

    (printout t "Has dado en el blanco!" crlf)
    (printout t "Vida de " ?ename ": " ?newehealth crlf)

    (retract ?s)
)


;Regla para esconderse
(defrule esconderse
    ?e <- (hide ?h)
    (test (eq ?h 0))
    ?a <- (agent (name ?aname) (state ?astate))
    (test (eq ?astate 1))
    =>
    (modify ?a (state 0))
    (printout t ?aname ", te has escondido. Ahora puedes tirar una habilidad(a), recargar(r) o cambiar(c) de arma." crlf)
    (retract ?e)
)

;Regla para recargar
(defrule recargar
    ?r <- (recharge ?h)
    (test (eq ?h 0))
    ?a <- (agent (name ?aname)(state ?astate) (charger ?wcharger))
    (test (eq ?astate 0))
    (test (<= ?wcharger 10))
    =>
    (modify ?a (charger 10))
    (modify ?a (state 1))
    (printout t ?aname ", has recargado. Ahora tu cargador vuelve a tener 10 balas." crlf)
    (retract ?r)
)


;Regla para cambiar de arma
(defrule cambio_arma
    ?n <- (new_weapon ?nwname)
    ?a <- (agent (name ?aname) (state ?astate))
    (weapon (weapon_name ?wname))
    (test (eq ?astate 0))
    =>

    (printout t "Has elegido: " ?nwname crlf)
    (modify ?a (weapon  ?nwname))
    (modify ?a (state 1))

    (printout t ?aname ", ahora tu arma es: " ?nwname crlf)
    (retract ?n)
)
