# would be nice if this worked :-(
echo "127.0.0.1 kerberos.example.com >> /etc/hosts"
# instead add --add-host kerberos.example.com:127.0.0.1 to docker run

krb5kdc
kadmind
echo "Kerberos services started"
tail -f /dev/null
