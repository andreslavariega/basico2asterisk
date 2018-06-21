# basico2asterisk
Proyecto de compilador que interpreta código en un lenguaje básico y lo convierte en lenguaje para asterisk.



 
Tabla de contenido
Necesidad:	3
Conceptos importantes	3
IVR:	3
Tonos DTMF	3
Donde son usados los sistemas IVR:	3
Permisos para correr bash	4
Caso por probar:	4
Reglas del lenguaje	5
Lista de funciones contempladas	7
Answer:	7
Playback	7
Forma de ejecutar	7
Archivo de Control	8
Formato del código de entrada	8
Codigo intermedio	8
Conclusiones	9
Referencias	9





Necesidad:
Generar un lenguaje de programación y su compilador que permita a un usuario sin conocimientos de Asterisk crear un IVR a partir de un lenguaje sencillo. 
El compilador deberá convertir este lenguaje a código Asterisk para poder se interpretado directamente.
Por lo que este Proyecto se puede definir como compilador que interpreta código en un lenguaje básico y lo convierte en lenguaje para asterisk.


Enlace GIT
En este enlace puede obtenerse el código:
https://github.com/andreslavariega/basico2asterisk


Conceptos importantes

IVR: 
La Respuesta de Voz Interactiva o IVR es una tecnología de telefonía que le permite a los clientes interactuar con el sistema de atención de la compañía a través de menúes de voz configurables, en tiempo real, utilizando tonos DTMF.

Tonos DTMF
Son usados para la señalización de telecomunicaciones sobre líneas telefónicas analógicas en la banda de frecuencia vocal entre teléfonos u otros equipos de comunicaciones y la central telefónica.

Donde son usados los sistemas IVR:
Los Sistemas IVR normalmente pueden manejar y dar servicio a altos volúmenes de llamadas telefónicas . Con un sistema de respuesta de voz interactiva las empresas pueden reducir los costos y mejorar la experiencia de los clientes, debido a que las personas que llaman obtienen la información que necesitan las 24 horas del día sin la necesidad de personal humano costoso.


Permisos para correr bash
Cuando se ejecuta  un script pasando el nombre de archivo del script a un intérprete (sh, python, perl, etc.), en realidad estás ejecutando el intérprete pasándole como argumento el programa que querés ejecutar. Por ejemplo, ejecutamos el intérprete sh pasándole el argumento miscript.sh.

En este compilador, se debe tener permisos de ejcución para que cualquier usuario pueda correr el compilador. Eso se dio con el siguiente comando.
chmod +x compilador
chmod +x analizadorlexico.sh
y los permisos quedarion del siguiente modo
-rwxr-xr-x 1 root root  347 Jun 21 16:58 compilador
-rwxr-xr-x 1 root root 2.7K Jun 21 16:31 lexico.sh


Donde cualquier usuario podrá ejecutar el comando, pero solo root podrá modificarlo.

Caso por probar:

Crear un IVR , desde un código básico. Este ivr deberá ser interpretado por el compilador para generar código Asterisk.



Reglas del lenguaje 

* Asterisk al ser un lenguaje de interpretación no utiliza la definición de variables.


Código básico	Asterisk	Notas
int=a	*no tipado	En Asterisk no se definen las variables . Sin embargo se hara definición de ellas en el código básico.

Se usara para definir lógicas en el IVR. 
como comparar si un numero ya marco en el dia, buscar en alguna base de datos, contar cantidad de llamadas entrantes.
Dial=100	*no tipado	En Asterisk no se definen las variables . Sin embargo se hará definición de ellas en el código básico.

El dial es una función básica de Asterisk. Y es la marcación a una extensión, número PSTN o custom. 
Audio bienvenida	*no tipado	En Asterisk no se definen las variables . Sin embargo se hará definición de ellas en el código básico.

Los audios son archivos en gsm o wav que serán reproducidos una vez que sean encontrados en la secuencia.
inicio	Answer(1)	La función de esta aplicación básicamente es la de descolgar la llamada entrante. Puede resultar trivial, pero hay que entender que en función de las aplicaciones que vengan a continuación es posible que sea necesario que nuestra máquina Asterisk ya tenga el control sobre el canal entrante (mediante el uso de esta aplicación).
;;comentario	;;comentario	Omite comentarios para la interpretación.
sim embargo si los pasa al código Asterisk para poder documentar directamente los archivos.
comando	exten => comando	Exten, es el prefijo para indicar un nuevo comando
Fin	Hangup	Simplemente, cuelga la llamada. No es necesario pasarle ningún parámetro especifico.



Lista de funciones contempladas


Answer: 

La función de esta aplicación básicamente es la de descolgar la llamada entrante. Puede resultar trivial, pero hay que entender que en función de las aplicaciones que vengan a continuación es posible que sea necesario que nuestra máquina Asterisk ya tenga el control sobre el canal entrante (mediante el uso de esta aplicación).

A nivel de mensaje SIP ejecutar esta aplicación es lo mismo que enviar un mensaje al par que llama de OK. Hay que considerar que en el momento que lanzamos esta aplicación al descolgar la llamada, ya comenzaría el ciclo de facturación del llamante por lo que eventualmente, a no ser que sea estrictamente necesario, no es una buena idea incluirla en nuestro dialplan por sistema o costumbre. Tenemos que saber si las aplicaciones sucesivas, realmente requieren que el canal este "contestado" para que funcionen correctamente.

Ejemplo de uso: que un robot telefónico conozca si esta cayendo en un buzon de voz o esta hablando con un humano. 

Playback

Sirve para reproducir una pista de audio contenida en un fichero dentro de nuestra máquina. El método de seleccion de esta pista, si solo especificamos el nombre, lo consultará en el directorio asociado al lenguaje que estemos utilizando para el canal especifico.

Durante la reproducción, la aplicación tiene el control del canal, esto quiere decir, que no se permiten lanzar otras Aplicaciones simultáneamente.

Dial

Esta aplicación sirve para realizar la llamada a un dispositivo concreto, pasándole argumentos o lo que es más común, una marcación concreta. Esta es la clásica función que realizan la mayor parte de las PBX, recibir una llamada, y pasarla a otro dispositivo (sea un troncal, una linea de un operador, o sencillamente un teléfono) utilizando un comando de este tipo.

Lo curioso de esta aplicación, es que no importa desde que origen entre el canal, podemos lanzar la llamada a otro origen del mismo medio, totalmente diferente (por ejemplo, una llamada entrante de un teléfono móvil, pasarela a un dispositivo basado en el protocolo IAX que se conecta a nuestra central). Toda la traducción y transcodificación de medios si es que hubiere, se realiza utilizando las características que nos ofrece nuestro sistema Asterisk.

En este compilador solo se contemplan extensiones y recursos bajo el protocolo SIP.

Forma de ejecutar

Ejecuta el analisador lexico
./lexico.sh instrucciones.lv

Segundo se ejecuta esto. donde estan las instrucciones. Este paso nos generara el código intermedio en “intermedio.lv”
./compilador Instrucciones.compilador


tercero se ejecuta el convertido del codigo intermedio al asterisk
./intermedio2asterisk intermedio.lv


Archivo de Control

El archivo en la siguiente ruta, sirve de control. Es decir, si el archivo existe el compilador continua. Si el archivo no existe el compilador se detiene.

Este archivo es autogenerado y eliminado por el mismo compilador.
	
/root/proyecto_asterisk_compilador/lineafinallexico


Formato del código de entrada 


El formato del código básico se divide en dos bloques. En uno se definen la lista de variables el cual se llama “definición de variables”; 
El segundo se llama instrucciones; y debajo de el se codifican la lista de instrucciones para ser interpretadas.

Definicion de variables 
.
.
.
.
instrucciones
.
.
.
.

Codigo intermedio

Se genera un archivo llamado intermedio lv. El cual contiene la salida del compilador lista para ser introducida a Asterisk.


Para introducir al Asterisk , correr el comando:

./intermedio2asterisk intermedio.lv




Conclusiones

Trabajar en este proyecto final me hizo comprender que se requiere de una sintaxis, gramática y léxicos de lenguajes específicos, ya que, al igual que el lenguaje humano, si no lo escribimos correctamente el compilador no realizara correctamente lo deseado por el programador. 

El proceso de compilación tiene varias etapas, y es importante como programador entender cada una de ellas nos da las siguientes ventajas:

- Encontrar el tipo de error al momento de estar programando.
- Optimizar código para que el compilador pueda trabajar mas rápido.
- Optimizar código para que nuestro software final sea mas rápido en procesamiento y consuma menos recursos. 


Referencias

Compiladores, Principios, técnicas y herramientas, Alfred V. Aho, Ravi Sethi, Jeffrey D.
Manual de Asterisk y otras hierbas. http://comunidad.asterisk-es.org/images/Intro-asterisk-uca.pdf
http://www.dlsi.ua.es/docencia/asignaturas/comp1/comp1.html
http://www.cps.unizar.es/~ezpeleta/COMPI
http://www.ii.uam.es/~alfonsec
Compiladores: Conceptos Fundamentales. B. Teufel, S. Schmidt, T. Teufel. Addison
Wesley Iberoamericana





