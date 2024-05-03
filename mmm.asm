PAGE 40,132

TITLE Maximo, minimo y Moda

COMMENT  * Realizar un programa que de 100 números en un arreglo tipo byte halle el valor mayor el menor
y la moda entregando cada uno de esos resultado en tres variables de memoria (una para cada
resultado) tipo byte.*

;se inicializara el stack a continuacion


;PUBLIC PROCEDIMIENTO

stack  segment para stack 'STACK'        
        db 64 dup ("STACK   ")        
stack   ends

data segment para memory 'DATA' 

	Datos	DB  213,35,35,176,131,2,214,198,50,87
			DB  65,80,40,38,223,56,169,67,164,201
			DB  244,157,171,180,146,12,141,6,243,241
			DB  80,248,156,199,92,9,192,230,69,52
			DB  5,1,126,35,11,117,175,20,58,160
			DB  175,230,57,132,156,60,129,177,123,30
			DB  202,110,135,109,40,198,26,213,173,205
			DB  117,35,18,68,187,85,166,87,75,243
			DB  117,157,210,125,17,233,242,116,120,122
			DB  249,104,90,206,38,249,244,247,126,133

	numMayor DB 0
	numMenor DB 0
	moda DB 0

data ends

code segment para 'code'
	assume cs:code,ss:stack,ds:data
	
Proceso	proc far        
	MOV AX,SEG DATA	;Estas dos instrucciones siempre las van a poner
	MOV DS,AX
	
;ACA EMPIEZA NUESTRO CODIGO
MOV CX, 99 ; SIZE OF ARRAY
MOV SI, 0 
MOV DI, 0

; primer ciclo para el ordenamiento burbuja
Ciclo1:
	PUSH CX ;MOVE SIZE ARRAY TO CX
	LEA SI, Datos ; OBTENEMOS LA POSICION INICIAL DEL ARREGLO Y LA COPIAMOS A DI
	MOV DI, SI

	MOV CX, 99;  NUMERO DE VECES QUE VAMOS A REPETIR EL CICLO
	Ciclo2: ; segundo ciclo para el ordenamiento burbuja
		INC DI ; NOS MOVEMOS A LA POSICION SIGUIENTE DEL ARREGLO PARA COMPARAR POSICION ACTUAL Y POSICION SIGUIENTE
		MOV AL, [SI]
	
		CMP AL, [DI] ; COMPARA SI AL ES MENOR A DI
		JBE noIntercambiar
	
		;intercambiamos los valores de posicion 
		MOV AH, [DI]
		MOV [DI], AL
		MOV [SI], AH
	
		noIntercambiar: ; EN CASO DE QUE LA POSICION ACTUAL SEA MENOR A LA SIGUIENTE NO HACE NADA Y COMPARA LOS SIGUIENTES VALORES
			INC SI
			LOOP Ciclo2
			POP CX
			LOOP Ciclo1
	
LEA SI, Datos ;Apuntamos a la posicion inicial y final para saber el mayor y menor
	
MOV AL, [SI]
MOV numMenor, AL
ADD SI, 99
MOV AL, [SI]
MOV numMayor, AL

;Comenzamos con moda
; Inicialización de registros y variables
MOV CL, 0           ; Inicializa CL a cero para almacenar temporalmente valores de datos
MOV AH, 0           ; Inicializa AH a cero para contar la cantidad de ocurrencias de la moda
MOV BH, 0           ; Inicializa BH a cero para contar la cantidad de ocurrencias de la moda
MOV SI, 0           ; Inicializa SI a cero para usar como índice para recorrer los datos
MOV DI, 0           ; Inicializa DI a cero para usar como índice para recorrer los datos

; Inicialización del primer dato como moda inicial
MOV CL, Datos[SI]   ; Carga el primer dato en CL
MOV moda, CL        ; Inicializa la variable 'moda' con el primer dato

; Etiqueta para el bucle principal
modaCmp:
    ; Compara el dato en CL con el dato en la dirección apuntada por DI
    CMP CL, Datos[DI]
    ; Salta a 'aumentar' si los datos son iguales
    JE aumentar

    ; Incrementa DI y compara si ha alcanzado la cantidad máxima de datos (100 en decimal)
    INC DI
    CMP DI, 064H
    JB modaCmp   ; Salta a 'modaCmp' si DI es menor que 100, es decir, si no se ha alcanzado el final de los datos

    ; Incrementa SI y compara si ha alcanzado la cantidad máxima de datos
    INC SI
    CMP SI, 064H
    JB reiniciaModa   ; Salta a 'reiniciaModa' si SI es menor que 100, es decir, si aún hay más datos para revisar

    JMP fin   ; Salta a 'fin' si se han revisado todos los datos

; Etiqueta para incrementar el contador de ocurrencias de la moda
aumentar:
    INC BH   ; Incrementa el contador de ocurrencias de la moda
    INC DI   ; Avanza al siguiente dato

    ; Compara el contador de ocurrencias actual con el máximo encontrado hasta ahora y salta a 'actualizaModa' si es mayor
    CMP AH, BH
    JB actualizaModa

    JMP modaCmp   ; Salta de nuevo al bucle principal

; Etiqueta para actualizar la moda y su contador de ocurrencias
actualizaModa:
    MOV AH, BH      ; Actualiza el contador de ocurrencias máximo
    MOV moda, CL    ; Actualiza la moda con el valor actual
    JMP modaCmp     ; Salta de nuevo al bucle principal

; Etiqueta para reiniciar la búsqueda de la moda con un nuevo valor de dato
reiniciaModa:
    MOV CL, Datos[SI]   ; Carga el próximo dato en CL
    MOV BH, 0           ; Reinicia el contador de ocurrencias a cero
    MOV DI, 0           ; Reinicia el índice para recorrer los datos a cero
    JMP modaCmp         ; Salta de nuevo al bucle principal

; Fin del programa
fin:

	

	
Proceso endp
code ends

END
