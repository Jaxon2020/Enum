import subprocess
import re
def main():

    ART4 = """
    
    
███████████████████████████████████
█─▄▄▄─█─▄▄─█▄─█─▄█─▄▄─█─▄─▄─█▄─▄▄─█
█─███▀█─██─██▄─▄██─██─███─████─▄█▀█
▀▄▄▄▄▄▀▄▄▄▄▀▀▄▄▄▀▀▄▄▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀
    
    

    """

    print(ART4)

    with open("data", "r") as f:
        data = f.read()


    open_ports = []

    for line in data.split("\n"):
        match = re.search(r"(\d+)/tcp\s+open", line)
        if match:
            open_ports.append(int(match.group(1)))

    print(open_ports)

    with open("open_ports.txt", "w") as f:
        for port in open_ports:
            f.write(str(port) + "\n")


    port_enumeration = {22:"ssh", 80:"web", 111:"rpc", 5432:"postgresql", 5901:"vnc"}

    for port in open_ports:
        if port in port_enumeration:
            print(f"Port {port} is open. Consider running {port_enumeration[port]} enumeration.")
        else:
            print(f"Unknown open port: {port}")


    answer = input("Do you wish to proceed with further enumeration(Y or N): ")

    if answer == "Y":
        print("Enumerating further, hold on...")

        if port in (80, 443):
            result = subprocess.run(["bash", "web.sh"], capture_output=True, text=True)
            if result.returncode == 0:
                print("Web enumeration script ran successfully")
            else:
                print("Web enumeration script failed with error: ")
                print(result.stderr)
        else:
            result = subprocess.run(["bash", "proto.sh"], capture_output=True, text=True)
            if result.returncode == 0:
                print("Protocol enumeration script ran successfully")
            else:
                print("Protocol enumeration script failed with error: ")
                print(result.stderr)

    else:
        print("Goodbye, thanks for the data.")

if __name__ == "__main__":
    main()