import std.socket;
import std.stdio;
import std.conv;
import std.string;


void main()
{
    Socket clientSocket = new TcpSocket();

    clientSocket.connect(new InternetAddress("127.0.0.1", 8080));
    writeln("Connected to server");

    clientSocket.send("Hello from client!");

    char[] buffer;
    long bytesRead = clientSocket.receive(buffer);
    writeln("Received from server: ", cast(string) buffer[0 .. bytesRead]);

    clientSocket.close();
}