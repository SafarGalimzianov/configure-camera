import subprocess
import json
import socket
from time import sleep
import sys
import os

SURVEILLANCE_IP_RANGE = 6
NTP_BAT_NAME = 'ntp.bat'

def ping_ip(ip):
    num_of_requests = 1
    time = 5000 # ms
    command = ['ping', '-n', str(num_of_requests), '-w', str(time), str(ip)]
    result = subprocess.run(command, stdout=subprocess.DEVNULL).returncode
    
    return result == 0

def get_local_ip():
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
            s.connect(("8.8.8.8", 80))
            local_ip = s.getsockname()[0]
            return local_ip
    except Exception as e:
        return "Exception"
    '''
    try:
        hostname = gethostname()
    except Exception as e:
        print(f'Error getting hostname: {e}')
    try:
        local_ip = gethostbyname(hostname)
    except Exception as e:
        print(f'Error getting local IP: {e}')
    return local_ip
    '''
    
def main():
    local_ip = get_local_ip()
    if local_ip.split('.')[-2] != str(SURVEILLANCE_IP_RANGE):
        print('Local IP is not in the expected range')
    
    print('Starting NTP server')
    base_dir = os.path.dirname(sys.executable) if getattr(sys, 'frozen', False) else os.path.dirname(os.path.abspath(__file__))
    ntp_path = os.path.join(base_dir, NTP_BAT_NAME)
    command = ['sudo', 'run', ntp_path]
    result = 0
    try:
        result = subprocess.run(command, stdout=subprocess.DEVNULL).returncode
        if result == 0:
            # user gets prompted to start admin command
            # and this is printed
            print('Successfull start of NTP server')
        else:
            print('Failed to start NTP server')
    except Exception as e:
        print(f'Error starting NTP server: {e}')
    sleep(3)
    
    print('Starting ping check')
    with open('camera_list.json', 'r', encoding='utf-8') as f:
        cameras = json.load(f)
        for camera in cameras:
            name = str(camera.get('Name')).strip()
            ip = str(camera.get('IP')).strip()
            if not ping_ip(ip):
                print(f'Name: {name if name else "NO NAME"} | IP: {ip} | Status: ', end = '\n', flush=True)
    print('\nFinish')
    sleep(3)

if __name__ == '__main__':
    main()