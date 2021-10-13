# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import socket

SOCK_HOST = 'localhost'
SOCK_PORT = 51859


sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((SOCK_HOST, SOCK_PORT))

while True:
    data = sock.recv(4096)
    if not data:
        break
    else:
        print(str(data))
        print(data)
        print("ECHO: " + repr(data))

sock.close()


# noinspection PyMissingOrEmptyDocstring
def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
    print(f'Hi, {name}')  # Press Ctrl+F8 to toggle the breakpoint.


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print_hi('PyCharm')

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
