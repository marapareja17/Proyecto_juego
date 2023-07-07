import clips
import logging
import time


def print_animado(texto):
    for letra in texto:
        print(letra, end='', flush=True)
        time.sleep(0.02)  # cambia el valor para ajustar la velocidad de impresión
    print()  # para agregar una nueva línea al final del texto


def main():
    logging.basicConfig(level=logging.DEBUG, format='%(message)s')
    env = clips.Environment()

    router = clips.LoggingRouter()
    env.add_router(router)

    #Carga del programa
    env.load('data_definition.clp')
    env.load('rules_definition.clp')

    env.reset()
    print_animado("\n\nEsto es un juego que hemos desarrollado inspirado en el juego de riot Valorant pero simplificado a un 1 vs 1.\n" +
                "\n" +
                "Te vas a enfrentar al agente 'Reyna', una famosa asesina en serie conocida como 'La Viuda'. Reyna tiene habilidades\n" + 
                "únicas que le permiten curarse después de eliminar a un enemigo y robar las habilidades de sus oponentes muertos.\n" +
                "\n" +
                "Pero, no te preocupes, tu también tendrás habilidades interesantes, y con destreza serás capaz de derrotarla, suerte!\n")

    print("Inciciando", end='', flush=True)
    for i in range(3):
        for j in range(3):
            print(".", end='', flush=True)
            time.sleep(0.5)  # ajusta el valor para la velocidad de carga de los puntos
        print("\b\b\b   \b\b\b", end='', flush=True)
        time.sleep(0.3)  # ajusta el valor para la velocidad de carga de la palabra "Iniciando"

    print("\n")
    print_animado("Aquí están los agentes disponibles:\n")

    #########################
    #Ejecución de las reglas#
    #########################

    env.run()

    continuar = True
    while continuar:
        print_animado("\nAntes de empezar puedes conocer la información del juego\n")
        accion = input("Conocer la información relevante de un agente: (info_agent)\n"+
                    "Conocer las armas disponibles: (weapons)\n"+
                    "Conocer la información sobre un arma: (weapon_info)\n"+
                    "Comenzar a jugar: (start)\n")

        # Validar la entrada del usuario
        while accion not in ["info_agent", "weapons", "weapon_info", "start"]:
            accion = input("Por favor, ingresa 'info_agent', 'weapons', 'weapon_info' o 'start': ")

        if accion == "info_agent":
            # conocer la info de un agente
            agent_name = input("Selecciona un agente para conocer información sobre este\n")
            print("Has seleccionado el agente ", agent_name)
            env.assert_string('(name_agent "' + agent_name + '")')
            env.run()
        elif accion == "weapons":
            # conocer armas disponibles
            print("Aquí están las armas disponibles:\n")
            env.assert_string('(weapon_names 0)')
            env.run()
        elif accion == "weapon_info":
            # Conocer la info disponible sobre las armas
            agent_weapon = input("Selecciona un arma para conocer información sobre esta\n")
            print("Has seleccionado el arma ", agent_weapon)
            env.assert_string('(weapon_info "' + agent_weapon + '")')
            env.run()
        elif accion == "start":
            continuar = False

    print_animado("\nTras ver la información disponible sobre los agentes es hora de elegir uno para poder empezar el juego:\n")
    agent_name = input("Elige tu agente: ")
    while agent_name not in ["Sova", "Raze", "Killjoy", "Viper", "Sage"]:
            agent_name = input("Por favor, ingresa un nombre adecuado: ")

    env.assert_string('(main_character ' + '"' + agent_name + '"' + ')')
    env.run()

    print_animado(agent_name + ", selecciona tu arma\n")
    agent_weapon = input("Weapon: ")
    while agent_weapon not in ["Classic", "Ghost","Judge", "Bucky", "Vandal", "Phantom"]:
            agent_weapon = input("Por favor, ingresa una de las armas anteriores: ")

    env.assert_string('(main_weapon ' + '"' + agent_weapon + '"' + ')')
    env.run()

    # disparar
    print_animado("\nIniciamos el juego, es hora de disparar:\n")
    time.sleep(1)

    env.assert_string('(shoot 0)')
    env.run()

    continuar = True 

    while continuar:
        eleccion = input("\nAhora puedes esconderte(e) o seguir disparando(d)\n")

        # Validar la entrada del usuario
        while eleccion not in ["e", "d"]:
            eleccion = input("Por favor, ingresa 'e' o 'd': ")

        if eleccion == "e":
            env.assert_string('(hide 0)')
            env.run()

            t = input("\n")

            while t not in ["a", "c","r"]:
                t = input("Por favor, ingresa 'a', 'c' o 'r': ")

            if t == "a":
                numero = input("Que habilidad eliges: 1, 2, 3 o 4?\n")
                print("\n")
                while numero not in ["1", "2", "3", "4"]:
                    numero = input("Por favor, ingresa un número correcto (1,2,3,4): ")
                env.assert_string('(abi ' + numero +')')
                env.run()
   
            if t == "r":
                env.assert_string('(recharge 0)')
                env.run()

            if t == "c":
                #armas disponibles
                print_animado("Aquí están las armas disponibles:\n")
                env.assert_string('(weapon_names 0)')
                env.run()

                print_animado(agent_name + " selecciona el arma que quieres ahora\n")
                agent_weapon = input("Weapon: ")

                while agent_weapon not in ["Classic", "Ghost","Judge", "Bucky", "Vandal", "Phantom"]:
                    agent_weapon = input("Por favor, ingresa una de las armas anteriores: ")

                env.assert_string('(new_weapon ' + '"' + agent_weapon + '"' + ')')
                env.run()

        else:
            print_animado("\nEs hora de disparar:")
            time.sleep(0.5)
            env.assert_string('(shoot 0)')
            env.run()

        # Si la vida del agente o la del enemigo es negativa - termina el juego
        for fact in env.facts():
            if fact.template.name == "agent":
                if fact["name"] == agent_name:
                    health = fact['health']
                    if health <= 0:
                        print_animado("\nVaya... Has sido eliminado.")
                        print("---------GAME OVER---------")
                        print("\n")
                        continuar = False
                        break
            elif fact.template.name == "enemy":
                if fact["name"] == "Reyna":
                    health = fact['health']
                    if health <= 0:
                        print_animado("\nReyna ha sido eliminada!")
                        print("---------YOU WIN---------\n" )
                        print("\n")  
                        print("\n")  
                        continuar = False
                        break


if __name__ == '__main__':
    main()
