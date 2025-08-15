import subprocess
import json
import socket
from time import sleep
import env


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
    if local_ip.split('.')[-2] != str(env.SURVEILLANCE_IP_RANGE):
        print('Local IP is not in the expected range')
    
    print('Starting NTP server')
    command = ['sudo', 'run', env.NTP_CONFIG_PATH]
    result = 0
    try:
        result = subprocess.run(command, stdout=subprocess.DEVNULL).returncode
    except Exception as e:
        print(f'Error starting NTP server: {e}')
    else:
        if result == 0:
            # user gets prompted to start admin command
            # and this is printed
            print('Successfull start of NTP server')
        else:
            print('Failed to start NTP server')

    print('Starting ping check')
    with open(env.DATA_PATH, 'r', encoding='utf-8') as f:
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