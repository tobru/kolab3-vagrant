# Vagrant box for Kolab 3 on Debian

For an introduction, please visit [tobrunet.ch](https://tobrunet.ch/articles/kolab-3-vagrant-box-with-puppet-provisioning/)

## Quickstart

```
git clone https://github.com/tobru/kolab3-vagrant.git
cd kolab3-vagrant
vagrant up [ ubuntu-trusty | debian-wheezy ]
vagrant ssh [ ubuntu-trusty | debian-wheezy ]
sudo -i
setup-kolab
```

## Good to know

### Accessing WAP and Roundcube Webmail

Apache is mapped to the local port 8080. So you can access the Roundcube
Webmail and the Kolab Web Admin Panel using the following URLs on your host:

* http://localhost:8080/roundcubemail/
* http://localhost:8080/kolab-webadmin/

*Note*: Vagrant is configured to automatically remap the ports. So have a look
at the output of Vagrant to see to which port it really mapped.

### api_url for NATed ports

To get the kolab-webadmin working, the api_url needs to be configured after `setup-kolab` in `/etc/kolab/kolab.conf`:

```
[kolab_wap]
[...]
api_url = http://localhost:80/kolab-webadmin/api
```

## The MIT License (MIT)

```
Copyright (c) 2015 Tobias Brunner

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

