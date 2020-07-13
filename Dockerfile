FROM centos:7.8.2003

RUN yum -y install krb5-server krb5-workstation screen vim

# backup original configs:
RUN cp /etc/krb5.conf /root
RUN cp /var/kerberos/krb5kdc/kdc.conf /root

ADD krb5.conf /etc/krb5.conf
ADD kdc.conf /var/kerberos/krb5kdc/kdc.conf
RUN echo "*/admin@EXAMPLE.COM	*" > /var/kerberos/krb5kdc/kadm5.acl

RUN kdb5_util create -s -P manager_database_password

# Create users: admin user with password
RUN kadmin.local -q "addprinc -pw admin admin/admin@EXAMPLE.COM"
# regular user with password
RUN kadmin.local -q "addprinc -pw hrt_1_pass hrt_1"
# regular user with random password
RUN kadmin.local -q "addprinc -randkey hrt_2"


# export keytabs
RUN mkdir -p /etc/security/keytabs
RUN kadmin.local -q "xst -k /etc/security/keytabs/hrt_1.keytab hrt_1"
RUN kadmin.local -q "xst -k /etc/security/keytabs/hrt_2.keytab hrt_2"
RUN chmod -R a+r /etc/security/keytabs

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh
