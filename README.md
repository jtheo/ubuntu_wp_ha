This is just a Proof of Concept made as exercise to build a Wordpress installation that can scale.

This PoC is directly influenced by the tutorials from SysAdminCast, follow those if you look for something more structured:
https://sysadmincasts.com/episodes/43-19-minutes-with-ansible-part-1-4

The are anti-pattern and worst practice like ssh-keys in clear text here because they are irrelevant.
Please, don't do that in production.

Automated Wordpress installation via WP Cli: https://indigotree.co.uk/automated-wordpress-installation-with-bash-wp-cli/


The bootscript has the ansible directory has a tar.gz encoded at the end with
tar zc ansible | uuencode - >> bootstrap-mgmt.sh

More info on http://www.linuxjournal.com/content/add-binary-payload-your-shell-scripts
