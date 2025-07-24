:: Остановить службу времени Windows
net stop w32time
:: Включить NTP сервер в реестре
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpServer /v Enabled /d 1 /t REG_DWORD /f
:: Сделать сервер NTP всегда доверенным
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config /v AnnounceFlags /d 5 /t REG_DWORD /f
:: Настроить запуск службы времени при наличие сети
sc triggerinfo w32time start/networkon stop/networkoff
:: Запустить службу времени Windows
net start w32time
:: Разрешить исходящие подключения по udp 123 порт
netsh advfirewall firewall add rule name="udp 123 out" dir=out protocol=udp localport=123 action=allow
:: Разрешить входящие подключения по udp 123 порт
netsh advfirewall firewall add rule name="udp 123 in" dir=in protocol=udp localport=123 action=allow
:: Вывести текущий конфиг w32time
w32tm /query /configuration
@echo off
pause