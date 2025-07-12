import std.socket;
import std.stdio;


void main()
{
    // Server
    Socket serverSocket = new TcpSocket();
    serverSocket.bind(new InternetAddress("0.0.0.0", 8080));
    serverSocket.listen(1);

    writeln("Server is created...");

    Socket clientSocket = serverSocket.accept();
    writeln("Connection established with ", clientSocket.remoteAddress);

    clientSocket.send("Hello from server!");
    clientSocket.close();
}
