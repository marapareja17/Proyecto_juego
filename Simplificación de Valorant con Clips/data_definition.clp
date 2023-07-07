; ********************************
; DEFINICIÓN DE DATOS
; ********************************

; Agente actual
(deftemplate agent
  (slot name (type STRING))
  (slot ability-1)
  (slot ability-2)
  (slot ability-3)
  (slot ability-4)
  (slot agent_type)
  (slot weapon)
  (slot health (type INTEGER))
  (slot state (type INTEGER))
  (slot charger (type INTEGER))
)

; Agentes disponibles
(deftemplate agents
  (slot name (type STRING))
  (slot ability-1)
  (slot ability-2)
  (slot ability-3)
  (slot ability-4)
  (slot agent_type)
  (slot health (type INTEGER))
  (slot state (type INTEGER))
  (slot charger (type INTEGER))
)

; Agente enemigo
(deftemplate enemy
    (slot name (type STRING))
    (slot ability-1)
    (slot ability-2)
    (slot ability-3)
    (slot ability-4)
    (slot agent_type)
    (slot weapon)
    (slot health (type INTEGER))
)

; Habilidades
(deftemplate ability-1
   (slot ability_name (type STRING))
    (slot ability_description (type STRING))
    (slot ability_damage (type INTEGER))
    (slot ability_type (type INTEGER))
    (slot ability_uses (type INTEGER))
)

(deftemplate ability-2
    (slot ability_name (type STRING))
    (slot ability_description (type STRING))
    (slot ability_type (type INTEGER))
    (slot ability_uses (type INTEGER))
    (slot healing_ability (type INTEGER))
    (slot ability_damage (type INTEGER))
)

(deftemplate ability-3
    (slot ability_name (type STRING))
    (slot ability_description (type STRING))
    (slot ability_damage (type INTEGER))
    (slot ability_type (type INTEGER))
    (slot ability_uses (type INTEGER))
)

(deftemplate ability-4
    (slot ability_name (type STRING))
    (slot ability_description (type STRING))
    (slot ability_damage (type INTEGER))
    (slot ability_type (type INTEGER))
    (slot ability_uses (type INTEGER))
)

; Tipo de agente
(deftemplate agent_type
    (slot agent_type_name (type STRING))
    (slot agent_type_description (type STRING))
)

; Arma
(deftemplate weapon
    (slot weapon_name (type STRING))
    (slot weapon_description (type STRING))
    (slot damage (type INTEGER))

)




; ********************************
; MAIN
; ********************************

(deffacts main_facts
    ; ********************************
    ; AGENTS
    ; ********************************

    ;Agente seleccionado
    (agent
        (name "")
        (ability-1 "")
        (ability-2 "")
        (ability-3 "")
        (ability-4 "")
        (agent_type "")
        (health 150)
        (state 1)
        (charger 10)
    )
    
    ;Agentes disponibles
    ;Raze
    (agents
        (name "Raze")
        (ability-1 "blast-pack")
        (ability-2 "paint-shells")
        (ability-3 "boom-bot")
        (ability-4 "showstoppe")
        (agent_type "Duelist")
        (health 150)
        (state 1)
        (charger 10)
    )

    ;Sage
    (agents
        (name "Sage")
        (ability-1 "slow-orb")
        (ability-2 "healing-orb")
        (ability-3 "barrier-orb")
        (ability-4 "resurrection")
        (agent_type "Sentinel")
        (health 150)
        (state 1)
        (charger 10)
    )

    ;Killjoy
    (agents
        (name "Killjoy")
        (ability-1 "turret")
        (ability-2 "nanoswarm")
        (ability-3 "alarm-bot")
        (ability-4 "showstoppe")
        (agent_type "Sentinel")
        (health 150)
        (state 1)
        (charger 10)
    )

    ;Viper
    (agents
        (name "Viper")
        (ability-1 "toxic-screen")
        (ability-2 "poison-cloud")
        (ability-3 "snake-bite")
        (ability-4 "vipers-pit")
        (agent_type "Controller")
        (health 150)
        (state 1)
        (charger 10)
    )

    ;Sova
    (agents
        (name "Sova")
        (ability-1 "shock-bolt")
        (ability-2 "recon-bolt")
        (ability-3 "owl-drone")
        (ability-4 "hunter's-fury")
        (agent_type "Initiator")
        (health 150)
        (state 1)
        (charger 10)
    )

    ;Agente enemigo
    ;Reyna
    (enemy
        (name "Reyna")
        (ability-1 "leer")
        (ability-2 "devour")
        (ability-3 "dismiss")
        (ability-4 "empress")
        (agent_type "Duelist")
        (health 150)
        (weapon "Phantom")
    )
    
    ; ********************************
    ; ABILITIES
    ; ********************************
    ;Raze    
    (ability-1
        (ability_name "blast-pack")
        (ability_description "Utiliza tu habilidad 'blast-pack' para moverte rápidamente por el mapa y causar daño a los enemigos.")
        (ability_damage 50)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-2
        (ability_name "paint-shells")
        (ability_description "Utiliza tu habilidad 'paint-shells' para dañar a los enemigos a través de las paredes y esquinas.")
        (ability_damage 70)
        (ability_type 1)
        (ability_uses 1)
    )    

    (ability-3
        (ability_name "boom-bot")
        (ability_description "Utiliza tu habilidad 'boom-bot' para encontrar y dañar a los enemigos.")
        (ability_damage 20)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-4
        (ability_name "showstoppe")
        (ability_description "Usa tu habilidad 'showstoppe' para disparar un cohete que inflige mucho daño a los enemigos.")
        (ability_damage 80)
        (ability_type 1)
        (ability_uses 1)
    )
    
    ;Sage
    (ability-1
        (ability_name "slow-orb")
        (ability_description "Utiliza tu habilidad 'slow-orb' para ralentizar a los enemigos y facilitar su eliminación.")
        (ability_damage 10)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-2
        (ability_name "healing-orb")
        (ability_description "Usa tu habilidad 'healing-orb' para curarte a ti mismo o a un compañero.")
        (ability_damage 0)
        (healing_ability 100)
        (ability_type 0)
        (ability_uses 1)
    )

    (ability-3
        (ability_name "barrier-orb")
        (ability_description "Utiliza tu habilidad 'barrier-orb' para crear un muro que te sirva de cobertura o para bloquear una zona.")
        (ability_damage 0)
        (ability_type 2)
        (ability_uses 1)
    )

    (ability-4
        (ability_name "resurrection")
        (ability_description "Usa tu habilidad 'resurrection' para revivir a un compañero caído y que tengas mas posibilidades de ganar.")
        (ability_damage 0)
        (ability_type 2)
        (ability_uses 1)
    )    
    
    ;Killjoy
    (ability-1
        (ability_name "turret")
        (ability_description "Utiliza tu habilidad 'turret' para disparar automáticamente a los enemigos y defender una zona específica.")
        (ability_damage 10)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-2
        (ability_name "nanoswarm")
        (ability_description "Usa tu habilidad 'nanoswarm' para desplegar una granada que inflige daño con el tiempo a los enemigos.")
        (ability_damage 70)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-3
        (ability_name "alarm-bot")
        (ability_description "Utiliza tu habilidad 'alarm-bot' para detectar a los enemigos cercanos y ralentizarlos.")
        (ability_damage 0)
        (ability_type 2)
        (ability_uses 1)
    )

    (ability-4
        (ability_name "showstoppe")
        (ability_description "Usa tu habilidad 'showstoppe' para desplegar un dispositivo que ralentiza y daña a los enemigos en una zona amplia.")
        (ability_damage 0)
        (ability_type 4)
        (ability_uses 1)
    )

    ;Viper
    (ability-1
        (ability_name "toxic-screen")
        (ability_description "Usa tu habilidad 'toxic-screen' para crear un muro de veneno que dañe a los enemigos.")
        (ability_damage 20)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-2
        (ability_name "poison-cloud")
        (ability_description "Usa tu habilidad 'poison-cloud' para desplegar una granada que crea una nube de veneno que daña a los enemigos.")
        (ability_damage 149)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-3
        (ability_name "snake-bite")
        (ability_description "Usa tu habilidad 'snake-bite' para desplegar una granada que crea un charco de veneno que daña a los enemigos.")
        (ability_damage 70)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-4
        (ability_name "vipers-pit")
        (ability_description "Usa tu habilidad vipers-pit para crear una gran área de veneno que dañe a los enemigos y oscurezca su visión.")
        (ability_damage 149)
        (ability_type 1)
        (ability_uses 1)
    )
    
    ;Sova
    (ability-1
        (ability_name "shock-bolt")
        (ability_description "Usa tu habilidad 'shock-bolt' para infligir daño a los enemigos a través de paredes y esquinas.")
        (ability_damage 70)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-2
        (ability_name "recon-bolt")
        (ability_description "Usa tu habilidad 'recon-bolt' para revelar la ubicación de los enemigos.")
        (ability_damage 0)
        (ability_type 1)
        (ability_uses 1)
    )

    (ability-3
        (ability_name "owl-drone")
        (ability_description "Utiliza tu habilidad 'owl-drone' para explorar y revelar la ubicación de los enemigos.")
        (ability_damage 0)
        (ability_type 2)
        (ability_uses 1)
    )

    (ability-4
        (ability_name "hunter's-fury")
        (ability_description "Usa tu habilidad 'hunter's-fury' para disparar una descarga de flechas que pueden revelar la ubicación de los enemigos e infligirles daño.")
        (ability_damage 80)
        (ability_type 1)
        (ability_uses 1)
    )


    ;habilidades enemigo
    (ability-1
        (ability_name "leer")
        (ability_description "Use your leer ability to cast a short distance eye that will blind enemies who look at it.")
        (ability_damage 0)
        (ability_type 1)
    )

    (ability-2
        (ability_name "devour")
        (ability_description "Use your devour ability to consume a nearby soul orb that heals Reyna for a significant amount over a short period of time.")
        (ability_damage 0)
        (healing_ability 100)
        (ability_type 0)
    )

    (ability-3
        (ability_name "dismiss")
        (ability_description "Use your dismiss ability to consume a nearby soul orb, becoming intangible for a short duration.")
        (ability_damage 0)
        (ability_type 1)
    )

    (ability-4
        (ability_name "empress")
        (ability_description "Use your empress ability to enter a frenzy, increasing firing, equip and reload speed dramatically.")
        (ability_damage 0)
        (ability_type 2)
    )
    

    ; ********************************
    ; WEAPONS
    ; ********************************

    ;hand weapons
    (weapon
        (weapon_name "Classic")
        (weapon_description "El modo de disparo principal es preciso cuando no está en movimiento, y también hay un modo de disparo en ráfaga para los encuentros cercanos.")
        (damage 26)
    )
    
    (weapon
        (weapon_name "Ghost")
        (weapon_description "El modo de disparo principal es perfecto para distancias cortas; si quieres acertar a objetivos situados a más de un metro, tendrás que apuntar con calma y precisión.")
        (damage 30)
    )

    ;shotgun
    (weapon
        (weapon_name "Judge")
        (weapon_description "El modo de disparo principal es perfecto para medias, cortas distancias; si quieres acertar a objetivos a más de un metro de distancia, será más difícil.")
        (damage 17)
    )

    (weapon
        (weapon_name "Bucky")
        (weapon_description "La Bucky es una escopeta que dispara 5 perdigones a la vez. Tiene una alta cadencia de fuego e inflige mucho daño.")
        (damage 60)
    )

    ;heavy weapons
    (weapon
        (weapon_name "Vandal")
        (weapon_description "Esta arma potente y precisa es temible cuando se dispara en ráfagas cortas. La Vandal inflige mucho daño a larga distancia y es ideal para impactar disparos.")
        (damage 40)
    )

    (weapon
        (weapon_name "Phantom")
        (weapon_description "El modo automático es perfecto para los encuentros cuerpo a cuerpo, mientras que las ráfagas cortas son el camino a seguir en cualquier otra situación. Es mucho más preciso si no estás disparando en movimiento.")
        (damage 39)
    )
    
    (start 0)
)
