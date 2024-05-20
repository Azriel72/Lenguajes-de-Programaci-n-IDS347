import ballerina/io;
import ballerina/os;
import ballerina/http;

public function main(string... args) returns error? {
    int opcion = 0;

    while opcion != 6 {
        io:println("Seleccione una opción:");
        io:println("1. Argumentos de línea de comando");
        io:println("2. Standard I/O & Error");
        io:println("3. Variables de ambiente");
       io:println("4. File I/O");
        io:println("5. Network I/O");
        io:println("6. Salir");

        string entrada = io:readln();
        int|error result = int:fromString(entrada);

        if result is int {
            opcion = result;
        } else {
            io:println("Error: La entrada no es un número válido.");
        }

        match opcion {
            1 => {
                // Argumentos de línea de comando
                io:println("Argumentos de línea de comando:");
                 foreach var arg in args {
                    io:println(arg);
                }
            }
            2 => {
                // Standard Streams: Standard Input, Output y Error
                io:println("\n\n(Standard Input) Ingrese el nombre de su mascota: ");
                string input = io:readln();
                io:println("\n\n(Standard Output) Su mascota se llama: " + input);
                if (input == "" ||  1 == 1) {
                    io:println("(Standard Error) Error: Usted no ingreso nada cuando le pedimos el nombre de su mascota o simplemente queremos enviar este error.");
                    panic error("Este es un error estándar provocado por una excepción.");
                }
            }
            3 => {
                // Variables de ambiente
                string envVariables = os:getEnv("OneDrive");
                io:println("Variables de entorno disponibles:");
                io:println(envVariables);
            }
            4 => {
                // Operaciones de archivos
                io:println("Ingrese la ruta del archivo a leer: ");
                string path = io:readln();
                string|io:Error content = io:fileReadString(path);
                io:println("Contenido del archivo: ", content);
                io:println("Ingrese el contenido a escribir en el mismo archivo: ");
                string newContent = io:readln();
                check io:fileWriteString(path, newContent);
                io:println("Se ha escrito en el archivo.");
            }
            5 => {
                // Crea un nuevo cliente HTTP
                http:Client clientEP = check new("http://google.com");
                // Realiza una solicitud GET
                http:Response res = check clientEP->get("/");
                // Obtiene el cuerpo de la respuesta
                string payload = check res.getTextPayload();
                // Imprime el cuerpo de la respuesta
                io:println(payload);
            }
            6 => {
                io:println("Saliendo del programa...");
            }
            _ => {
                io:println("Opción inválida. Por favor, ingrese una opción válida.");
            }
        }
    }
}