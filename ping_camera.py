import subprocess
import json
from time import sleep

def ping_ip(ip):
    num_of_requests = 1
    time = 5000 # ms
    command = ['ping', '-n', str(num_of_requests), '-w', str(time), str(ip)]
    result = subprocess.run(command, stdout=subprocess.DEVNULL).returncode
    
    return result == 0

def main():
    print('Starting')
    with open('camera_list.json', 'r', encoding='utf-8') as f:
        cameras = json.load(f)
        for camera in cameras:
            name = str(camera.get('Name')).strip()
            ip = str(camera.get('IP')).strip()
            if not ping_ip(ip):
                print(f'Name: {name if name else "NO NAME"} | IP: {ip} | Status: ', end = '', flush=True)
    print('\nFinish')
    sleep(5)

if __name__ == '__main__':
    main()