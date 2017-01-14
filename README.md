This is just a Proof of Concept made as exercise to build a Wordpress installation that can scale.

This PoC is directly influenced by the tutorials from SysAdminCast, follow those if you look for something more structured:
https://sysadmincasts.com/episodes/43-19-minutes-with-ansible-part-1-4

The are anti-pattern and worst practice like ssh-keys in clear text here because they are irrelevant.
Please, don't do that in production.

Automated Wordpress installation via WP Cli: https://indigotree.co.uk/automated-wordpress-installation-with-bash-wp-cli/


The bootscript has the ansible directory has a tar.gz encoded at the end with
tar zc ansible | uuencode - >> bootstrap-mgmt.sh

More info on http://www.linuxjournal.com/content/add-binary-payload-your-shell-scripts


The infrastructure is composed of
- a management node with the ansible installed and a set of playbooks and roles deployed through a boot script.
- a load balancer built using HAProxy
- two web servers using classic LAMP
- a backend node with MySQL, Memcached and NFS

### Usage
Once downloaded the project from GitHub, you should start the Vagrant project and once completed login on the mgmt node and run the ansible main playbook: 
    git clone https://github.com/jtheo/ubuntu_wp_ha
    cd ubuntu_wp_ha
    vagrant up
    vagrant ssh mgmt
    cd ansible
    ansible-playbook main.yml

At the end of the operations, browsing http://localhost:8080 you should be able to see a WordPress blog with an image in the header and a few blog posts with Lorem Ipsum and similar ones.

This a raw schema of the infrastructure:

             +----------+
             |          |
             |   LB     |
             |          |
           +-+----------+--+
           |               |
           |               |
    +------v--+        +---v------+
    | WEB     |        | WEB      |
    |         |        |          |
    ++----+---+--+    ++------+--++
     |    |      |    |       |  |
     |    |      |    |       |  |
     |    | +----v----v---+   |  |
     |    +->NFS          <---+  |
     |      |    Memcached|      |
     +------> MySQL       <------+
            +-------------+
