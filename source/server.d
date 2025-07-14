import std.socket;
import std.stdio;
import std.string;
import std.conv;
import core.thread;


void receiveMessages(Socket client)
{
    char[1024] buffer;

    while(true)
    {
        long received = client.receive(buffer);

        if(received <= 0)
        {
            break;
        }

        writeln("\n[Client]: ", cast(string) buffer[0..received].strip());
        write("You: ");

        stdout.flush();
    }
}

void main()
{
    Socket serverSocket = new TcpSocket();
    serverSocket.bind(new InternetAddress("127.0.0.1", 8080));
    serverSocket.listen(3);

    writeln("Server is created!");
    writeln("Waiting for a client");

    Socket clientSocket = serverSocket.accept();

    writeln("The client connected");
    writeln("Connection established with ", clientSocket.remoteAddress);

    new Thread(() => receiveMessages(clientSocket)).start(); 

    while (true)
    {
        write("You: ");

        stdout.flush();

        string msg = readln().strip();

        if (msg == "exit")
        {
            break;
        }

        clientSocket.send(msg);
    }

    clientSocket.close();
    serverSocket.close();

    writeln("The server is stopped");
}
