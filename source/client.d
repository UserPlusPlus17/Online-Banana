import std.socket;
import std.stdio;
import std.conv;
import std.string;
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

        writeln("\n[Server]: ", cast(string) buffer[0..received].strip());
        write("You: ");

        stdout.flush();
    }
}

void main()
{
    Socket clientSocket = new TcpSocket();

    clientSocket.connect(new InternetAddress("127.0.0.1", 8080));
    writeln("Connected to server");

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

    writeln("Disconnected from the server");
}