#!/bin/bash

# Función para procesar la lógica de las 3 oportunidades
# Argumentos: $1=Número A, $2=Número B, $3=Operador, $4=Resultado Correcto
procesar_pregunta() {
    local a=$1
    local b=$2
    local operador=$3
    local correcto=$4
    local intentos=3
    local respuesta

    while [ $intentos -gt 0 ]; do
        read -p "¿Cuánto es $a $operador $b? " respuesta
        
        if [[ "$respuesta" -eq "$correcto" ]]; then
            echo "¡Felicidades! La respuesta es correcta."
            return 0
        else
            intentos=$((intentos - 1))
            if [ $intentos -gt 0 ]; then
                echo "Respuesta incorrecta. ¡Inténtalo de nuevo! (Te quedan $intentos intentos)"
            else
                echo "Lo siento, has agotado tus intentos. La respuesta correcta era: $correcto"
            fi
        fi
    done
}

# Bucle principal del menú
opcion=0
while [ "$opcion" -ne 9 ]; do
    echo -e "\nQUIZ MATEMÁTICO"
    echo "1) Problemas de suma"
    echo "2) Problemas de resta"
    echo "3) Problemas de multiplicación"
    echo "4) Problemas de división"
    echo "9) Salir"
    read -p "Elige una opción: " opcion

    case $opcion in
        1)
            # Suma: A y B entre 0 y 100
            a=$((RANDOM % 101))
            b=$((RANDOM % 101))
            procesar_pregunta $a $b "+" $((a + b))
            ;;
        2)
            # Resta: A y B entre 0 y 100, A >= B
            a=$((RANDOM % 101))
            b=$((RANDOM % 101))
            if [ $a -lt $b ]; then
                temp=$a
                a=$b
                b=$temp
            fi
            procesar_pregunta $a $b "-" $((a - b))
            ;;
        3)
            # Multiplicación: A (1-100), B (1-10)
            a=$((RANDOM % 100 + 1))
            b=$((RANDOM % 10 + 1))
            procesar_pregunta $a $b "*" $((a * b))
            ;;
        4)
            # División: A (1-20), B (1-10). Nuevo A = A * B para exactitud
            base_a=$((RANDOM % 20 + 1))
            b=$((RANDOM % 10 + 1))
            a=$((base_a * b))
            procesar_pregunta $a $b "/" $((a / b))
            ;;
        9)
            echo "¡Gracias por jugar! Hasta pronto."
            ;;
        *)
            echo "Opción no válida, por favor intenta de nuevo."
            ;;
    esac
done