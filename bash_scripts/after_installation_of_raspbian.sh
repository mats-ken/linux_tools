# for NOOBS_v2_8_2


sudo apt update
sudo apt upgrade
sudo apt install cmake subversion subversion-tools samba
sudo apt install xinetd



# activate sshd

settings - service - ssh - on


# fix ip addr

sudo vi /etc/dhcpcd.conf
static ip_address=192.168.0.xxx/24

sudo shutdown -r now

ip a | grep inet



# activate svn server with xinetd and svnserve

sudo adduser svn


sudo vi /etc/xinetd.d/svnserve
service svnserve
{
    disable         = no
    socket_type     = stream
    wait            = no
    user            = svn
    server          = /usr/bin/svnserve
    server_args     = -i -r /home/svn
    log_on_failure  += USERID
}


sudo vi /etc/services
svnserve        3690/tcp        subversion      # Subversion protocol
svnserve        3690/udp        subversion


sudo service xinetd restart

su svn
cd
svnadmin create test_repo
vi test_repo/conf/svnserve.conf
anon-access = write
auth-access = write


#samba
https://qiita.com/ARBALEST000/items/78f459567e1e90de99e5

sudo vi /etc/samba/smb.conf
sudo systemctl restart smbd

