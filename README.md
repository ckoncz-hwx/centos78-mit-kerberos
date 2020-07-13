# MIT Kerberos on Centos 7.8

Get a KDC that issues renewable tickets on Centos 7.8

- build the image:
```
docker build -t krb5-on-rl78 .
```
- start it:
```
docker run --add-host kerberos.example.com:127.0.0.1 --name my-kdc krb5-on-rl78
```
- test it:
```
docker exec -it my-kdc bash
[root@de163a8fd9be /]# kinit -kt /etc/security/keytabs/hrt_1.keytab hrt_1
[root@de163a8fd9be /]# klist -f
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: hrt_1@EXAMPLE.COM

Valid starting     Expires            Service principal
07/13/20 15:01:18  07/14/20 15:01:18  krbtgt/EXAMPLE.COM@EXAMPLE.COM
	renew until 07/16/20 15:01:18, Flags: FRI
[root@de163a8fd9be /]# kinit -R
[root@de163a8fd9be /]# klist -f
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: hrt_1@EXAMPLE.COM

Valid starting     Expires            Service principal
07/13/20 15:01:37  07/14/20 15:01:37  krbtgt/EXAMPLE.COM@EXAMPLE.COM
	renew until 07/16/20 15:01:18, Flags: FRIT
[root@de163a8fd9be /]#
```