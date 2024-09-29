import time
hello_world = "ІДІ НАХУЙ"

for i in range(len(hello_world)-1):
    animated_text = hello_world[:i+1].rjust(len(hello_world)-2)
    
    for letter in range(ord('a'), ord('z')+1):
        print(animated_text + chr(letter), end='\r')
        time.sleep(0.05)
    
    print(end='\r')  

print()