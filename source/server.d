import std.socket;
import std.stdio;


void main()
{
    Socket serverSocket = new TcpSocket();
    serverSocket.bind(new InternetAddress("127.0.0.1", 8080));
    serverSocket.listen(10);

    writeln("Server is created!");

    Socket clientSocket = serverSocket.accept();
    writeln("Connection established with ", clientSocket.remoteAddress);

    clientSocket.send("Hello from server!");
    clientSocket.close();
}
