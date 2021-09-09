cd "C:\Users\joshu\Downloads\SQL\instantclient_19_12"
sqlldr userid=system/123@192.168.233.130:1521/XE control=../archivoControl.ctl log=log/archivoControl.log bad=bad/archivoControl.bad
@pause